package view.shell.settings 
{
	import data.Preferences;
	import feathers.controls.Slider;
	import starling.events.Event;
	import ui.themes.Theme;
	import ui.windows.Window;
	import utils.updates.IUpdateDispatcher;

	public class SettingsWindow extends Window
	{
		private static const GAP:int = 30;
		
		private var muteButton:MuteButton;
		private var soundController:VolumeController;
		private var musicController:VolumeController;
		
		public function SettingsWindow(flow:IUpdateDispatcher, preferences:Preferences)
		{		
			this.muteButton = new MuteButton(flow, preferences);
			
			this.soundController = new VolumeController(Theme.SOUND_SETTING, flow);
			this.musicController = new VolumeController(Theme.MUSIC_SETTING, flow);
			
			this.addChild(this.muteButton);
			this.addChild(this.soundController);
			this.addChild(this.musicController);
			
			this.addEventListener(Event.ADDED_TO_STAGE, this.locate)
		}
		
		public function locate(event:Event):void
		{	
			this.soundController.x = SettingsWindow.GAP;
			this.musicController.x = SettingsWindow.GAP;
			
			this.soundController.y = SettingsWindow.GAP;
			this.musicController.y = this.soundController.y + this.soundController.height + SettingsWindow.GAP;

		}
		
	}

}