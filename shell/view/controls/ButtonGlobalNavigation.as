package view.controls 
{
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.events.NavigationEvent;
	
	public class ButtonGlobalNavigation extends Button
	{
		
		public function ButtonGlobalNavigation(y:int, title:String = "title") 
		{
			super(Texture.fromColor(100, 20, 0xFFCCFF33), title);
			
			this.fontName = "HiLo-Deco"; this.fontSize = 18;
			
			this.x = 10;
			this.y = y;
			
			this.addEventListener(Event.TRIGGERED, this.handleTrigger);
		}
		
		private function handleTrigger(event:Event):void
		{
			event.stopImmediatePropagation();
			
			this.dispatchEvent(new NavigationEvent(this.text));
		}
	}

}