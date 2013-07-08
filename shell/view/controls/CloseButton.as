package view.controls 
{
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class CloseButton extends Button
	{
		
		public function CloseButton()
		{
			super(Texture.fromColor(15, 20, 0xFF00FF00), "X");
			
			this.fontName = "HiLo-Deco"; this.fontSize = 18;
			
			this.y = 0;
			this.addEventListener(Event.ADDED_TO_STAGE, setX);
		}
		
		private function setX(event:Event):void
		{
			this.x = this.parent.width - this.width;
			this.removeEventListener(Event.ADDED_TO_STAGE,setX);
		}
		
	}

}