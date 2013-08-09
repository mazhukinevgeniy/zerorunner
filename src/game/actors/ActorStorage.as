package game.actors 
{
	import game.actors.ActorsFeature;
	import game.actors.types.ActorLogicBase;
	import game.actors.types.BroodmotherBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	import game.state.IGameState;
	import game.time.ICacher;
	import game.time.Time;
	import game.ZeroRunner;
	import utils.informers.IStoreInformers;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	internal class ActorStorage implements ICacher, ISearcher
	{
		protected var broods:Vector.<BroodmotherBase>;
		
		
		private var cacheV:Vector.<ActorLogicBase>;
		
		private var width:int = Metric.xDistanceActorsAllowed * 2;
		private var height:int = Metric.yDistanceActorsAllowed * 2;
		private var cacheLength:int;
		
		private var cacheIsCleared:Boolean;
		
		
		private var tLC:CellXY;
		private var toTLC:DCellXY = new DCellXY( - Metric.xDistanceActorsAllowed, - Metric.yDistanceActorsAllowed);
		
		private var center:CellXY;
		
		public function ActorStorage(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			flow.addUpdateListener(ZeroRunner.aftertick);
			
			this.cacheLength = this.width * this.height;
			
			this.cacheV = new Vector.<ActorLogicBase>(this.cacheLength, true);
			
			flow.dispatchUpdate(Time.addCacher, this);
			flow.dispatchUpdate(Time.addCacher, this);
		}
		
		update function prerestore():void
		{
			this.cacheIsCleared = false;
			
			this.center = ActorsFeature.SPAWN_CELL;
			this.tLC = ActorsFeature.SPAWN_CELL.applyChanges(this.toTLC);
			
			for (var i:int = 0; i < this.cacheLength; i++)
				this.cacheV[i] = null;
		}
		
		update function aftertick():void
		{
			this.tLC.setValue(this.center.x, this.center.y);
			this.tLC.applyChanges(this.toTLC);
		}
		
		public function cache():void
		{
			var i:int, x:int, y:int;
			var actor:ActorLogicBase;
			
			if (this.cacheIsCleared)
			{/*
				for (i = 0; i < this.state.actualActorsCap; i++)
				{
					actor = this.actors[i];
					
					if (this.canBeCached(actor))
					{
						x = actor.x; y = actor.y;
						
						if (this.cacheV[(x - this.tLC.x) + (y - this.tLC.y) * this.width])
						{
							ActorBase.iFlow.dispatchUpdate(ActorsFeature.removeActor, actor.id);
						}
						else
						{
							this.cacheV[(x - this.tLC.x) + (y - this.tLC.y) * this.width] = actor;
						}
					}
					else if (actor.isActive)
					{
						ActorBase.iFlow.dispatchUpdate(ActorsFeature.removeActor, actor.id);
					}
				}
			*/
			}
			else
			{
				for (i = 0; i < this.cacheLength; i++)
					this.cacheV[i] = null;
			}
			this.cacheIsCleared = !this.cacheIsCleared;
		}
		
		final protected function canBeCached(actor:ICoordinated):Boolean
		{
			var x:int = actor.x;
			var y:int = actor.y;
			
			return (!(x < this.tLC.x) && (x < this.tLC.x + this.width)
					&&
					!(y < this.tLC.y) && (y < this.tLC.y + this.height));
		}
		
		final public function findObjectByCell(x:int, y:int):ActorLogicBase
		{
			if (!(x < this.tLC.x) && (x < this.tLC.x + this.width)
				&&
				!(y < this.tLC.y) && (y < this.tLC.y + this.height))
				return this.cacheV[(x - this.tLC.x) + (y - this.tLC.y) * this.width];
			else return null;
		}
		
		
		final public function get character():ICoordinated
		{
			return this.center;
		}
		/*
		update function moveActor(actor:ActorBase, change:DCellXY, delay:int):void
		{
			this.putInCell(actor.x - change.x, actor.y - change.y);
			this.putInCell(actor.x, actor.y, actor);
		}
		
		update function removeActor(id:int):void
		{
			var actor:ActorBase = this.actors[id];
			
			actor.isActive = false;
			this.putInCell(actor.x, actor.y);
		}
		
		final protected function putInCell(x:int, y:int, item:ActorBase = null):void
		{
			if (!(x < this.tLC.x) && (x < this.tLC.x + this.width)
				&&
				!(y < this.tLC.y) && (y < this.tLC.y + this.height))
			this.cacheV[x - this.tLC.x + (y - this.tLC.y) * this.width] = item;
		}
		*/
		
		
		final update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(ISearcher, this);
		}
	}

}