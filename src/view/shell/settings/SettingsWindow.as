package view.shell.settings 
{
	import binding.IBinder;
	import feathers.controls.Slider;
	import starling.events.Event;
	import view.shell.WindowBase;
	import view.themes.ShellTheme;

	public class SettingsWindow extends WindowBase
	{
		private static const GAP:int = 30;
		
		private var soundController:VolumeController;
		private var musicController:VolumeController;
		
		public function SettingsWindow(binder:IBinder)
		{		
			this.soundController = new VolumeController(ShellTheme.SOUND);
			this.musicController = new VolumeController(ShellTheme.MUSIC);
			
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