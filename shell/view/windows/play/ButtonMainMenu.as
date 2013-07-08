package view.windows.play 
{
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ButtonMainMenu extends Button
	{
		
		public function ButtonMainMenu(texture:Texture, title:String = "title" ) 
		{
			super(texture, title);
			
			this.fontName = "HiLo-Deco"; this.fontSize = 18;
			this.addEventListener(Event.ADDED_TO_STAGE, setX);
		}
		
		private function setX(event:Event):void
		{
			this.x = this.parent.width / 2 - this.width / 2;
			this.y = this.parent.height / 2 - this.height / 2;
			
			this.removeEventListener(Event.ADDED_TO_STAGE, setX);
		}
		
	}

}