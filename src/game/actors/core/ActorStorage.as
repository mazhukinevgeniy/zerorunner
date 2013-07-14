package game.actors.core 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import chaotic.informers.IStoreInformers;
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
	
	public class ActorStorage implements ICacher, IActorCache, ISearcher
	{
		private var actors:Vector.<ActorBase>;
		
		
		private var cacheV:Vector.<ActorBase>;
		
		private var cacheWidth:int;
		private var cacheHeight:int;
		private var cacheLength:int;
		
		private var cacheIsCleared:Boolean;
		
		private var flow:IUpdateDispatcher;
		
		private var command:ActorManipulator;
		private var listener:IActorListener;
		
		private var tLC:CellXY;
		
		public function ActorStorage(view:IActorListener, flow:IUpdateDispatcher) 
		{
			this.listener = view;
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			this.flow = flow;
			
			this.cacheWidth = Metric.xDistanceActorsAllowed * 2;
			this.cacheHeight = Metric.yDistanceActorsAllowed * 2;
			this.cacheLength = this.cacheWidth * this.cacheHeight;
			
			this.actors = new Vector.<ActorBase>(ActorsFeature.CAP, true);
			this.cacheV = new Vector.<ActorBase>(this.cacheLength, true);
			
			flow.dispatchUpdate(Time.addCacher, this);
			flow.dispatchUpdate(Time.addCacher, this);
		}
		
		public function prerestore():void
		{
			this.command.refill(this.actors, true);
			
			this.cacheIsCleared = false;
		}
		
		public function cache():void
		{
			var i:int;
			
			if (this.cacheIsCleared)
			{
				for (i = 0; i < ActorsFeature.CAP; i++)
				{
					// TODO: fill the cache; perform outOfBounds check
				}
			}
			else
			{
				for (i = 0; i < this.cacheLength; i++)
					this.cacheV[i] = null;
			}
			
			this.cacheIsCleared = !this.cacheIsCleared;
		}
		
		public function findObjectByCell(cell:CellXY):ActorBase
		{
			return this.cacheV[(cell.x - this.tLC.x) + (cell.y - this.tLC.y) * this.cacheWidth];
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
		
		public function cleanCell(x:int, y:int):void
		{
			this.cacheV[x - this.tLC.x + (y - this.tLC.y) * this.cacheWidth] = null;
		}
		
		public function putInCell(x:int, y:int, item:ActorBase = null):void
		{
			this.cacheV[x - this.tLC.x + (y - this.tLC.y) * this.cacheWidth] = item;
		}
		
		
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(ISearcher, this);
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			ActorBase.iFlow = this.flow;
			ActorBase.iSearcher = this;
			ActorBase.iScene = table.getInformer(IScene);
			ActorBase.iListener = this.listener;
			ActorBase.iInput = table.getInformer(IKnowInput);
			
			this.command = new ActorManipulator(table.getInformer(IGameState));
		}
	}

}