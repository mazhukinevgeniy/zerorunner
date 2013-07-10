package view.controls 
{
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import flash.text.TextFormat;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.events.NavigationEvent;
	
	public class ButtonGlobalNavigation extends Button
	{
		
		public function ButtonGlobalNavigation(y:int, title:String = "title") 
		{
			this.labelFactory = function():ITextRenderer
			{
				var test:TextFieldTextRenderer = new TextFieldTextRenderer();
				test.textFormat = new TextFormat("HiLo-Deco", 18, 0x000000);
				test.embedFonts = true;
				return test;
			}
			
			
			this.label = title;
			this.x = 10;
			this.y = y;
			this.defaultSkin = new Image(Texture.fromColor(100, 20, 0xFFCCFF33));
			this.downSkin = new Image(Texture.fromColor(100, 20, 0xFFCCDD33));

			
			this.addEventListener(Event.TRIGGERED, this.handleTrigger);
		}
		
		private function handleTrigger(event:Event):void
		{
			event.stopImmediatePropagation();
			
			this.dispatchEvent(new NavigationEvent(this.label));
		}
	}

}