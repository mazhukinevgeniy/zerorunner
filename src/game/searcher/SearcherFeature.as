package game.searcher 
{
	import game.actors.ActorsFeature;
	import game.actors.types.ActorLogicBase;
	import game.metric.ICoordinated;
	import game.time.ICacher;
	import utils.updates.IUpdateDispatcher;
	
	public class SearcherFeature implements ICacher, ISearcher
	{
		public static const cacheScene:String = "cacheScene";
		
		
		private var sceneCacheWidth:int;
		private var sceneCacheHeight:int;
		
		private var sceneCache:Vector.<int>
		
		private var actorCacheWidth:int;
		private var actorCacheHeight:int;
		
		
		public function SearcherFeature(flow:IUpdateDispatcher) 
		{
			
			
			flow.workWithUpdateListener(this);
			
			//flow.addUpdateListener(ActorsFeature.setCenter);
			//flow.addUpdateListener(ActorsFeature.moveCenter);
		}
		
		
		public function cache():void
		{
			
		}
		
		
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
	}

}