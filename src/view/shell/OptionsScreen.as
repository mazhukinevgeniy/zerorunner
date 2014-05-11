package view.shell 
{
	import binding.IBinder;
	import controller.interfaces.ISoundController;
	import feathers.controls.Screen;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import view.shell.controls.VolumeController;
	import view.themes.ShellTheme;
	
	
	internal class OptionsScreen extends Screen 
	{
		private const GAP:int = 30;
		
		private var soundController:VolumeController;
		private var musicController:VolumeController;
		
		private var controller:ISoundController;
		
		public function OptionsScreen(binder:IBinder) 
		{
			super();
			
			
			this.controller = binder.soundController;
			
			this.soundController = new VolumeController(ShellTheme.SOUND);
			this.musicController = new VolumeController(ShellTheme.MUSIC);
			
			this.addChild(this.soundController);
			this.addChild(this.musicController);
			
			this.addEventListener(Event.ADDED_TO_STAGE, this.locate)
			this.musicController.slider.addEventListener(Event.CHANGE, this.handleSliderChange);
			this.soundController.slider.addEventListener(Event.CHANGE, this.handleSliderChange);
		}
		
		
		public function locate(event:Event):void
		{	
			this.soundController.x = this.GAP;
			this.musicController.x = this.GAP;
			
			this.soundController.y = this.GAP;
			this.musicController.y = this.soundController.y + this.soundController.height + this.GAP;
			//TODO: use layout instead
		}
		
		
		private function handleSliderChange(event:Event):void
		{
			//TODO: consider actually using sound/music flag
			var target:EventDispatcher = event.target;
			
			if (target == this.soundController.slider)
			{
				this.controller.setSoundValue(this.soundController.slider.value / 100);
			}
			else if (target == this.musicController.slider)
			{
				this.controller.setMusicValue(this.musicController.slider.value / 100);
			}
		}
	}
	//TODO: activate buttons so they actually mute stuff

}