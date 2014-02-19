package game.core 
{
	import starling.display.Sprite;
	import starling.text.TextField;
	
	internal class PauseView extends Sprite
	{//TODO: move to renderer
		private var notification:TextField;
		
		public function PauseView() 
		{
			super();
			
			this.notification = new TextField(500, 40, "Game paused", "HiLo-Deco", 30);
			this.addChild(this.notification);
			
			this.notification.y += 50;
			
		}
		
	}

}