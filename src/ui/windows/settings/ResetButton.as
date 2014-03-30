package ui.windows.settings 
{
	import feathers.controls.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import ui.windows.Window;
	import utils.updates.IUpdateDispatcher;
	
	public class ResetButton extends Sprite
	{
		private var flow:IUpdateDispatcher;
		
		private var button:Button;
		
		public function ResetButton(flow:IUpdateDispatcher)
		{
			this.button = new Button();
			this.addChild(this.button);
			button.label = "Reset Button";
			
			this.button.addEventListener(Event.TRIGGERED, this.handleTriggered);
			this.button.addEventListener(Event.RESIZE, this.locate);
			
			this.flow = flow;
		}
	
			
		private function handleTriggered(event:Event):void
		{
			//TODO: tell about the risk. user 'll lose all his droids!
			
			this.flow.dispatchUpdate(Update.resetProgress);
		}
		
		private function locate(event:Event):void
		{
			this.x = 0
			this.y = Window.HEIGHT - this.button.height;
		}
	}
}