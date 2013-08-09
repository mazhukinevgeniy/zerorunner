package game.searcher 
{
	import game.actors.ActorsFeature;
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
			
			flow.addUpdateListener(ActorsFeature.setCenter);
			flow.addUpdateListener(ActorsFeature.moveCenter);
		}
		
	}

}