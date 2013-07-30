package game.actors.core 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.informers.IStoreInformers;
	import game.actors.ActorsFeature;
	import game.actors.view.ActiveCanvas;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	import game.time.ICacher;
	import game.time.Time;
	import game.ZeroRunner;
	
	use namespace update;
	
	internal class ActorStorage implements ICacher, ISearcher
	{
		protected var actors:Vector.<ActorBase>;
		
		protected var view:ActiveCanvas;
		
		
		private var cacheV:Vector.<ActorBase>;
		
		private var width:int = Metric.xDistanceActorsAllowed * 2;
		private var height:int = Metric.yDistanceActorsAllowed * 2;
		private var cacheLength:int;
		
		private var cacheIsCleared:Boolean;
		
		
		private var tLC:CellXY;
		private var toTLC:DCellXY = new DCellXY( - Metric.xDistanceActorsAllowed, - Metric.yDistanceActorsAllowed);
		
		public function ActorStorage(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			flow.addUpdateListener(ZeroRunner.aftertick);
			flow.addUpdateListener(ActorsFeature.moveActor);
			flow.addUpdateListener(ActorsFeature.removeActor);
			
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
			
			for (var i:int = 0; i < this.cacheLength; i++)
				this.cacheV[i] = null;
		}
		
		update function aftertick():void
		{
			this.getCharacterCell(this.tLC);
			this.tLC.applyChanges(this.toTLC);
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
				
				for (var j:int = 0; j < this.cacheLength; j++)
				{
					actor = this.cacheV[this.cacheLength - (1 + j)];
					
					if (actor && actor.active)
					{
						this.view.setLayerOf(actor.id, i);
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
		
		final protected function canBeCached(actor:ActorBase):Boolean
		{
			var x:int = actor.x;
			var y:int = actor.y;
			
			return (!(x < this.tLC.x) && (x < this.tLC.x + this.width)
					&&
					!(y < this.tLC.y) && (y < this.tLC.y + this.height));
		}
		
		final public function findObjectByCell(x:int, y:int):ActorBase
		{
			if (!(x < this.tLC.x) && (x < this.tLC.x + this.width)
				&&
				!(y < this.tLC.y) && (y < this.tLC.y + this.height))
				return this.cacheV[(x - this.tLC.x) + (y - this.tLC.y) * this.width];
			else return null;
		}
		
		final public function getCharacterCell(cell:CellXY):void
		{
			var ccell:CellXY = this.actors[0].cell;
			cell.setValue(ccell.x, ccell.y);
		}
		final public function get character():ICoordinated //TODO: check if it's shrinkable
		{
			return this.actors[0];
		}
		
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
		
		
		
		final update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(ISearcher, this);
		}
	}

}