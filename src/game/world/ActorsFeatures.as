package game.world 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodsFeature;
	import game.world.broods.IGiveBroods;
	import game.world.broods.ItemLogicBase;
	import utils.updates.update;
	
	use namespace update;
	
	public class ActorsFeatures
	{
		private var actors:Vector.<ItemLogicBase>;
		
		private var broods:IGiveBroods;
		
		public function ActorsFeatures(foundations:GameFoundations) 
		{
			this.broods = new BroodsFeature(foundations, this as ISearcher);
			
			new WindFeature(foundations.flow);
		}
		
		update function prerestore():void
		{
			
		}
	}

}