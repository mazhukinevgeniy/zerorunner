package game.world.broods.fog 
{
	import game.utils.GameFoundations;
	import game.world.broods.ItemViewBase;
	
	internal class FogView extends ItemViewBase
	{
		
		public function FogView(foundations:GameFoundations) 
		{
			super(foundations);
			
			this.scaleX = this.scaleY = 0.7;
		}
		
	}

}