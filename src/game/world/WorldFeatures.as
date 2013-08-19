package game.world 
{
	import flash.utils.ByteArray;
	import game.utils.GameFoundations;
	import game.world.broods.BroodsFeature;
	import game.world.broods.ItemLogicBase;
	import game.world.cache.ActorsFeature;
	import game.world.cache.SceneFeature;
	import game.world.cache.SearcherFeature;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	public class WorldFeatures extends ActorsFeatures implements ISearcher
	{
		private var scene:ByteArray;
		
		private var actorCache:Vector.<ItemLogicBase>;
		
		private var cacheDelta:int;
		
		private var sectors:SectorsFeature;
		
		public function WorldFeatures(foundations:GameFoundations) 
		{
			this.sceneCache = new ByteArray();
			
			SearcherFeature
			
			new SceneFeature(foundations.flow);
			new ActorsFeature(foundations, new BroodsFeature(foundations, this));
			
			this.sectors = new SectorsFeature(foundations, this);
			
			var flow:IUpdateDispatcher = foundations.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
		}
		
		override update function prerestore():void
		{
			super.update::prerestore();
			
			this.scene.length = 0;
			this.scene.length = 
		}
		
		public function setActorCache(x:int, y:int, value:ItemLogicBase):void
		{
			
		}
	}

}