package view.shell 
{
	import binding.IBinder;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	import view.shell.controls.SoundRegulator;
	import view.shell.events.ShellEvent;
	import view.shell.factories.createButton;
	
	
	internal class OptionsScreen extends Screen 
	{
		
		public function OptionsScreen(binder:IBinder) 
		{
			super();
			
			
			for (var i:int = 0; i < View.NUMBER_OF_SOUND_TYPES; i++)
				this.addChild(new SoundRegulator(i, binder));
			
			
			var quit:Button = createButton("BACK");
			quit.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			this.addChild(quit);
		}
		
		
		private function handleQuitTriggered():void
		{
			this.dispatchEventWith(ShellEvent.SHOW_MAIN);
		}
	}
	//TODO: activate buttons so they actually mute stuff

}