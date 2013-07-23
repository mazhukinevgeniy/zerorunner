package game.actors.core 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.informers.IGiveInformers;
	import chaotic.informers.IStoreInformers;
	import game.achievements.IActorStatistic;
	import game.actors.ActorsFeature;
	import game.actors.modules.ActorManipulator;
	import game.actors.view.IActorListener;
	import game.input.IKnowInput;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	import game.scene.IScene;
	import game.state.IGameState;
	import game.time.ICacher;
	import game.time.Time;
	import game.ZeroRunner;
	
	public class ActorStorage implements ICacher, ISearcher
	{
		private var actors:Vector.<ActorBase>;
		
		
		private var cacheV:Vector.<ActorBase>;
		
		private var width:int = Metric.xDistanceActorsAllowed * 2;
		private var height:int = Metric.yDistanceActorsAllowed * 2;
		private var cacheLength:int;
		
		private var cacheIsCleared:Boolean;
		
		private var flow:IUpdateDispatcher;
		
		private var command:ActorManipulator;
		private var listener:IActorListener;
		
		private var tLC:CellXY;
		private var toTLC:DCellXY = new DCellXY( - Metric.xDistanceActorsAllowed, - Metric.yDistanceActorsAllowed);
		
		public function ActorStorage(view:IActorListener, flow:IUpdateDispatcher) 
		{
			this.listener = view;
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.tick);
			flow.addUpdateListener(ZeroRunner.aftertick);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			this.flow = flow;
			
			this.cacheLength = this.width * this.height;
			
			this.actors = new Vector.<ActorBase>(ActorsFeature.CAP, true);
			this.cacheV = new Vector.<ActorBase>(this.cacheLength, true);
			
			flow.dispatchUpdate(Time.addCacher, this);
			flow.dispatchUpdate(Time.addCacher, this);
		}
		
		update function prerestore():void
		{
			this.cacheIsCleared = false;
			
			this.tLC = ActorsFeature.SPAWN_CELL.applyChanges(this.toTLC);
			
			this.command.refill(this.actors, true);
			
			this.cache(); 
			this.cache();
		}
		
		update function tick():void
		{
			this.command.act(this.actors);
		}
		
		update function aftertick():void
		{
			this.getCharacterCell(this.tLC);
			this.tLC.applyChanges(this.toTLC);
			
			this.command.refill(this.actors);
		}
		
		public function cache():void
		{
			var i:int, x:int, y:int;
			var actor:ActorBase;
			
			if (this.cacheIsCleared)
			{
				for (i = 0; i < ActorsFeature.CAP; i++)
				{
					actor = this.actors[i];
					x = actor.x; y = actor.y;
					
					if (!(x < this.tLC.x) && (x < this.tLC.x + this.width)
						&&
						!(y < this.tLC.y) && (y < this.tLC.y + this.height))
					{
						this.cacheV[(x - this.tLC.x) + (y - this.tLC.y) * this.width] = actor;
					}
					else if (actor.isActive)
					{
						this.listener.unparent(actor.id);
						
						actor.isActive = false;
					}
				}
				
				for (var j:int = 0; j < this.cacheLength; j++)
				{
					actor = this.cacheV[this.cacheLength - (1 + j)];
					
					if (actor)
					{
						this.listener.setLayerOf(actor.id, i);
						i--;
					}
				}
			}
			else
			{
				for (i = 0; i < this.cacheLength; i++)
					this.cacheV[i] = null;
			}
			
			this.cacheIsCleared = !this.cacheIsCleared;
		}
		
		public function findObjectByCell(x:int, y:int):ActorBase
		{
			if (!(x < this.tLC.x) && (x < this.tLC.x + this.width)
				&&
				!(y < this.tLC.y) && (y < this.tLC.y + this.height))
				return this.cacheV[(x - this.tLC.x) + (y - this.tLC.y) * this.width];
			else return null;
		}
		
		public function getCharacterCell(cell:CellXY):void
		{
			var ccell:CellXY = this.actors[0].cell;
			cell.setValue(ccell.x, ccell.y);
		}
		public function get character():ICoordinated
		{
			return this.actors[0];
		}
		
		public function putInCell(x:int, y:int, item:ActorBase = null):void
		{
			if (!(x < this.tLC.x) && (x < this.tLC.x + this.width)
				&&
				!(y < this.tLC.y) && (y < this.tLC.y + this.height))
			this.cacheV[x - this.tLC.x + (y - this.tLC.y) * this.width] = item;
		}
		
		
		
		update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(ISearcher, this);
		}
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			ActorBase.iFlow = this.flow;
			ActorBase.iSearcher = this;
			ActorBase.iScene = table.getInformer(IScene);
			ActorBase.iStat = table.getInformer(IActorStatistic);
			ActorBase.iListener = this.listener;
			ActorBase.iInput = table.getInformer(IKnowInput);
			
			this.command = new ActorManipulator(table.getInformer(IGameState));
		}
	}

}