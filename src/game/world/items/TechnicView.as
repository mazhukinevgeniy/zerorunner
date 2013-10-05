package game.world.items 
{
	import game.core.GameFoundations;
	import game.core.metric.ICoordinated;
	import game.world.items.utils.ItemViewBase;
	
	internal class TechnicView extends ItemViewBase
	{
		
		public function TechnicView(foundations:GameFoundations) 
		{
			super(foundations);
		}
		
		internal function animateSoldering(target:ICoordinated, delay:int):void
		{
			
		}
	}

}