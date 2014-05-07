package view.shell.windows.settings 
{
	import data.Preferences;
	import feathers.controls.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import ui.windows.Window;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class MuteButton extends Sprite
	{	
		private static const MUTE_BUTTON_WIDTH:int = 80;
		private static const MUTE_BUTTON_HEIGHT:int = 20;
		
		private var flow:IUpdateDispatcher;
		
		private var button:Button;
		
		public function MuteButton(flow:IUpdateDispatcher, preferences:Preferences) 
		{
			super();
			
			this.button = new Button();
			this.addChild(this.button);
			
			this.button.addEventListener(Event.TRIGGERED, this.handleTriggered);
			this.button.addEventListener(Event.RESIZE, this.locate);
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.toggleMute);
			
			if (preferences.mute)
				this.button.label = "Unmute";
			else
				this.button.label = "Mute";
		}
		
		private function locate(event:Event):void
		{
			this.x = Window.WIDTH - this.button.width;
			this.y = Window.HEIGHT - this.button.height;
		}
		
		private function handleTriggered(event:Event):void
		{
			this.flow.dispatchUpdate(Update.toggleMute);
		}
		
		update function toggleMute():void
		{
			this.toggleTitle();
		}
		
		
		private function toggleTitle():void
		{
			if (this.button.label == "Mute")
				this.button.label = "Unmute";
			else
				this.button.label = "Mute";
		}
	}

}