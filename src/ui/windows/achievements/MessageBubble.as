package ui.windows.achievements 
{
	import feathers.controls.Label;
	import starling.display.Image;
	import starling.display.Sprite;
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
		}
		
		
		public function updateMessage(testMessage:String, mouseX:Number, mouseY:Number):void
		{
			const OFFSET:int = 15;
			
			this.message.text = testMessage;
			
			if (mouseX + this.width < Main.WIDTH)
				this.x = mouseX + OFFSET;
			else
				this.x = Main.WIDTH - (this.width + OFFSET);
			
			if (mouseY + this.height < Main.HEIGHT)
				this.y = mouseY + OFFSET;
			else
				this.y = Main.HEIGHT - (this.height + OFFSET);
			
			
			if (this.message.height != lastHeight)
			{
				this.background.height = this.message.height;
				this.lastHeight = this.message.height;
			}
		}
		
	}

}