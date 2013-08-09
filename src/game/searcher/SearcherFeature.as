package game.searcher 
{
	import game.actors.ActorsFeature;
	import game.actors.types.ActorLogicBase;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import game.time.ICacher;
	import game.ZeroRunner;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class SearcherFeature implements ICacher, ISearcher
	{
		public static const cacheScene:String = "cacheScene";
		
		private var center:ICoordinated;
		private var cacheCenter:CellXY;
		
		private var sceneCacheWidth:int;
		private var sceneCacheHeight:int;
		
		private var sceneCache:Vector.<int>
		
		private var actorCacheWidth:int;
		private var actorCacheHeight:int;
		
		private var cacheStepsDone:int;
		
		public function SearcherFeature(flow:IUpdateDispatcher) 
		{
			this.cacheCenter = new CellXY(0, 0);
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.setCenter);
			flow.addUpdateListener(ZeroRunner.restore);
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
		
		public function findObjectByCell(x:int, y:int):ActorLogicBase
		{
			return null;
		}
		public function getCenter():ICoordinated
		{
			return null;
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			return 3;
		}
		
		/**
		 * Caching
		 */
		
		public function cache():void
		{
			const NUMBER_OF_STEPS:int = 5;
			
			this["cache" + this.cacheStepsDone]();
			
			this.cacheStepsDone = (this.cacheStepsDone + 1) % NUMBER_OF_STEPS;
		}
		
		private function cache0():void
		{
			this.cacheCenter.setValue(this.center.x, this.center.y);
		}
		
		private function cache1():void
		{
			
		}
		
		private function cache2():void
		{
			
		}
		
		private function cache3():void
		{
			
		}
		
		private function cache4():void
		{
			
		}
	}

}