package view.windows.achievements 
{
	import feathers.controls.Label;
	import starling.display.DisplayObject;
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
		
		
		public function updateMessage(testMessage:String, target:DisplayObject):void
		{
			const OFFSET:int = 10;
			
			this.message.text = testMessage;
			this.message.validate(); //TODO: find better way to solve the validation problem
			
			if (target.x + target.width + OFFSET + this.width < Main.WIDTH)
				this.x = target.x + target.width + OFFSET;
			else
				this.x = target.x - (this.width + OFFSET);
			
			if (target.y + target.height / 2 + this.height / 2 < Main.HEIGHT)
			{
				if (target.y + target.height / 2 - this.height / 2 < 0)
					this.y = OFFSET;
				else
					this.y = target.y + target.height / 2 - this.height / 2;
			}
			else this.y = Main.HEIGHT - (this.height + OFFSET);
			
			if (this.message.height != lastHeight)
			{
				this.background.height = this.message.height;
				this.lastHeight = this.message.height;
			}
		}
		
	}

}