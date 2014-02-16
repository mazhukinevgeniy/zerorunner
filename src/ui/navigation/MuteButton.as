package ui.navigation 
{
	import data.viewers.PreferencesViewer;
	import feathers.controls.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class MuteButton extends Sprite
	{	
		private var flow:IUpdateDispatcher;
		
		private var button:Button;
		
		public function MuteButton(flow:IUpdateDispatcher, preferences:PreferencesViewer) 
		{
			super();
			
			this.button = new Button();
			this.button.nameList.add(ExtendedTheme.MUTE_BUTTON);
			this.addChild(this.button);
			
			this.button.addEventListener(Event.TRIGGERED, this.handleTriggered);
			this.button.addEventListener(Event.ADDED_TO_STAGE, this.locate);
			
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
			this.x = Main.WIDTH - this.button.width;
			this.y = Main.HEIGHT - this.button.height;
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