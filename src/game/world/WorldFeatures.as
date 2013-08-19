package game.world 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodsFeature;
	import game.world.cache.ActorsFeature;
	import game.world.cache.SceneFeature;
	import game.world.cache.SearcherFeature;
	import game.world.sectors.SectorsFeature;
	
	public class WorldFeatures 
	{
		
		public function WorldFeatures(foundations:GameFoundations) 
		{
			var world:SearcherFeature = new SearcherFeature(foundations);
			
			var broods:BroodsFeature = new BroodsFeature(foundations, world);
			
			new SceneFeature(foundations.flow);
			new ActorsFeature(foundations, broods);
			
			new SectorsFeature(foundations, world);
		}
		
	}

}