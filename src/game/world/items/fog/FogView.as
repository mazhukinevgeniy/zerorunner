package game.world.items.fog 
{
	import game.core.GameFoundations;
	import game.world.items.ItemViewBase;
	
	internal class FogView extends ItemViewBase
	{
		
		public function FogView(foundations:GameFoundations) 
		{
			super(foundations);
			
			this.scaleX = this.scaleY = 0.7;
		}
		
	}

}