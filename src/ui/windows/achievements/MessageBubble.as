package ui.windows.achievements 
{
	import feathers.controls.Label;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import ui.themes.ExtendedTheme;
	
	public class MessageBubble extends Sprite
	{
		private static const WIDTH:Number = 200;
		
		private var message:Label;
		private var background:Image;
		
		private var lastHeight:Number;
		
		public function MessageBubble() 
		{
			this.message = new Label();
			this.message.maxWidth = MessageBubble.WIDTH;
			this.message.nameList.add(ExtendedTheme.MESSAGE);
			
			this.background = new Image(Texture.fromColor(10, 10, 0x50FFFFFF));
			this.background.width = MessageBubble.WIDTH;
			
			this.lastHeight = 0;
			
			this.addChild(this.background);
			this.addChild(this.message);
			
			this.addEventListener(Event.ADDED, this.changeHeight);
		}
		
		private function changeHeight(event:Event):void
		{
			if (this.message.height != lastHeight)
			{
				this.background.height = this.message.height;
				this.lastHeight = this.message.height;
				
				if (this.y + this.height > Main.HEIGHT)
					this.y = this.y - this.height;
			}
		}
		
		public function updateMessage(testMessage:String, mouseX:Number, mouseY:Number):void
		{
			this.message.text = testMessage;
			
			if (mouseX + this.width < Main.WIDTH)
				this.x = mouseX + 10;
			else
				this.x = mouseX - this.width;
				
			this.y = mouseY;
		}
		
	}

}