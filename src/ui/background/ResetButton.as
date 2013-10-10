package ui.background 
{
	import feathers.controls.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;
	
	public class ResetButton extends Sprite
	{
		private var flow:IUpdateDispatcher;
		
		private var button:Button;
		
		public function ResetButton(flow:IUpdateDispatcher)
		{
			this.button = new Button();
			this.button.nameList.add(ExtendedTheme.RESET_BUTTON);
			this.addChild(this.button);
			
			this.button.addEventListener(Event.TRIGGERED, this.handleTriggered);
			this.button.addEventListener(Event.ADDED_TO_STAGE, this.locate);
			
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
			this.y = Main.HEIGHT - this.button.height;
		}
	}
}