package game.world.cache 
{
	import game.utils.GameFoundations;
	import game.utils.metric.CellXY;
	import game.utils.metric.DCellXY;
	import game.utils.metric.ICoordinated;
	import game.utils.metric.Metric;
	import game.utils.time.ICacher;
	import game.world.broods.ItemLogicBase;
	import game.world.ISearcher;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class SearcherFeature implements ICacher, ISearcher
	{
		
		private var flow:IUpdateDispatcher;
		
		private var center:ICoordinated;
		
		/**/
		internal var cacheCenter:CellXY;
		
		internal var sceneCache:Vector.<int>;
		internal var actorCache:Vector.<ItemLogicBase>;
		
		internal var cacheWidth:int;
		internal var cacheHeight:int;
		
		/**/
		
		private var cacheStepsDone:int;
		
		public function SearcherFeature(foundations:GameFoundations) 
		{
			this.flow = foundations.flow;
			
			new Renderer(this, foundations);
			
			this.cacheCenter = new CellXY(0, 0);
			
			this.flow.workWithUpdateListener(this);
			
			this.flow.addUpdateListener(Update.setCenter);
			this.flow.addUpdateListener(Update.addActor);
			this.flow.addUpdateListener(Update.moveActor);
			this.flow.addUpdateListener(Update.removeActor);
			this.flow.addUpdateListener(Update.restore);
			
			const NUMBER_OF_STEPS:int = 3;
			for (var i:int = 0; i < NUMBER_OF_STEPS; i++)
				this.flow.dispatchUpdate(Update.addCacher, this);
			
			this.cacheWidth = Metric.CELLS_IN_VISIBLE_WIDTH + 4 + Metric.CELLS_IN_VISIBLE_WIDTH % 2;
			this.cacheHeight = Metric.CELLS_IN_VISIBLE_HEIGHT + 6 + Metric.CELLS_IN_VISIBLE_HEIGHT % 2;
			
			this.sceneCache = new Vector.<int>(this.cacheWidth * this.cacheHeight, true);
			this.actorCache = new Vector.<ItemLogicBase>(this.cacheWidth * this.cacheHeight, true);
		}
		
		update function restore():void
		{
			this.cacheStepsDone = 0;
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
		}
		
		/**
		 * Data access methods
		 */
		
		public function findObjectByCell(x:int, y:int):ItemLogicBase
		{
			if (this.isCachable(x, y))
				return this.getUnsafeActor(x, y);
			else return null;
		}
		
		public function getCenter():ICoordinated
		{
			return this.center;
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			if (this.isCachable(x, y))
				return this.getUnsafeScene(x, y);
			else return SceneFeature.ROAD;
		}
		
		
		internal function getUnsafeScene(x:int, y:int):int
		{
			x -= this.cacheCenter.x - this.cacheWidth / 2;
			y -= this.cacheCenter.y - this.cacheHeight / 2;
			
			return this.sceneCache[x + y * this.cacheWidth];
		}
		
		internal function getUnsafeActor(x:int, y:int):ItemLogicBase
		{
			x -= this.cacheCenter.x - this.cacheWidth / 2;
			y -= this.cacheCenter.y - this.cacheHeight / 2;
			
			return this.actorCache[x + y * this.cacheWidth];
		}
		
		/**
		 * Caching
		 */
		
		public function cache():void
		{
			const NUMBER_OF_STEPS:int = 3;
			
			this["cache" + this.cacheStepsDone]();
			
			this.cacheStepsDone = (this.cacheStepsDone + 1) % NUMBER_OF_STEPS;
		}
		
		private function cache0():void //0
		{
			this.cacheCenter.setValue(this.center.x, this.center.y);
			
			var actorCacheLength:int = this.cacheWidth * this.cacheHeight;
			for (var i:int = 0; i < actorCacheLength; i++)
			{
				this.actorCache[i] = null;
			}
		}
		
		private function cache1():void //1
		{
			this.flow.dispatchUpdate(Update.cacheScene, this.sceneCache, this.cacheCenter, 
										this.cacheWidth, this.cacheHeight);
		}
		
		private function cache2():void //2
		{
			this.flow.dispatchUpdate(Update.cacheActors, this.actorCache, this.cacheCenter, 
										this.cacheWidth, this.cacheHeight);
		}
		
		/**
		 * Actors tracking
		 */
		
		update function addActor(item:ItemLogicBase):void
		{
			this.putActorInCell(item.x, item.y, item);
		}
		
		update function moveActor(actor:ItemLogicBase, change:DCellXY, delay:int):void
		{
			this.putActorInCell(actor.x - change.x, actor.y - change.y);
			this.putActorInCell(actor.x, actor.y, actor);
		}
		
		update function removeActor(actor:ItemLogicBase):void
		{
			this.putActorInCell(actor.x, actor.y);
		}
		
		/**
		 * Utils
		 */
		
		private function putActorInCell(x:int, y:int, item:ItemLogicBase = null):void
		{
			if (this.isCachable(x, y))
			{
				x -= this.cacheCenter.x - this.cacheWidth / 2;
				y -= this.cacheCenter.y - this.cacheHeight / 2;
				
				this.actorCache[x + y * this.cacheWidth] = item;
			}
		}
		
		private function isCachable(x:int, y:int):Boolean
		{
			return (!(x < this.cacheCenter.x - this.cacheWidth / 2)) && 
				   (x < this.cacheCenter.x + this.cacheWidth / 2) &&
				   (!(y < this.cacheCenter.y - this.cacheHeight / 2)) && 
				   (y < this.cacheCenter.y + this.cacheHeight / 2);
		}
	}

}