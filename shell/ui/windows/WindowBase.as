package ui.windows 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.controls.CloseButton;
	
	public class WindowBase extends Sprite
	{
		private var closeButton:CloseButton;
		
		public function WindowBase(width:int, height:int) 
		{
			var tmp:Quad = new Quad(width, height, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
			this.x = (Main.WIDTH - this.width) / 2;
			this.y = (Main.HEIGHT - this.height) / 2;
			
			
			this.closeButton = new CloseButton();
			this.addChild(this.closeButton);
			
			this.closeButton.addEventListener(Event.TRIGGERED, this.closeYourself);
		}
		
		protected function closeYourself(event:Event):void
		{
			throw new Error("Must implement!");
		}
	}

}