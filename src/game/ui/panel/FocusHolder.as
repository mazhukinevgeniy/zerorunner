package game.ui.panel 
{
	import starling.display.Sprite;
	
	internal class FocusHolder extends Sprite
	{
		
		public function FocusHolder() 
		{
			this.graphics.beginFill(0xFFFFFF, Number.MIN_VALUE);
			this.graphics.drawRect(0, 0, Main.WIDTH, Main.HEIGHT);
			this.graphics.endFill();
			
			this.useHandCursor = false;
			this.visible = false;
		}
		
	}

}