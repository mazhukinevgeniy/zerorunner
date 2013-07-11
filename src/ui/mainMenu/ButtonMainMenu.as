package ui.mainMenu 
{
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import flash.text.TextFormat;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	internal class ButtonMainMenu extends Button
	{
		
		public function ButtonMainMenu(y:Number = 0, title:String = "title" ) 
		{
			super();
			
			this.width = MainMenu.WIDTH_BUTTON;
			this.height = MainMenu.HEIGHT_BUTTON;
			this.defaultSkin = new Image(Texture.fromColor(this.width, this.height, 0xFFFFFF));//не очень работает, но и не надо
			this.downSkin = new Image(Texture.fromColor(this.width, this.height, 0x000000));
			
			this.labelFactory = function():ITextRenderer
			{
				var newRender:TextFieldTextRenderer = new TextFieldTextRenderer();
				newRender.embedFonts = true;
				newRender.textFormat = new TextFormat("HiLo-Deco", 18);
				return newRender;
			}
			this.label = title;
			this.y = y;
			
			this.addEventListener(Event.ADDED_TO_STAGE, setX);
		}
		
		private function setX(event:Event):void
		{
			this.x = this.parent.width / 2 - this.width / 2;
			//this.y = this.parent.height / 2 - this.height / 2;
			
			this.removeEventListener(Event.ADDED_TO_STAGE, setX);
		}
		
	}

}