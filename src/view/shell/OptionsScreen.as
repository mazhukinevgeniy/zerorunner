package view.shell 
{
	import binding.IBinder;
	import controller.observers.ISoundObserver;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	import view.shell.controls.SoundRegulator;
	import view.shell.events.ShellEvent;
	import view.shell.factories.createButton;
	
	
	internal class OptionsScreen extends Screen implements ISoundObserver
	{
		private var regulators:Vector.<SoundRegulator>;
		
		public function OptionsScreen(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
			super();
			
			this.regulators = new Vector.<SoundRegulator>(View.NUMBER_OF_SOUND_TYPES, true);
			
			for (var i:int = 0; i < View.NUMBER_OF_SOUND_TYPES; i++)
				this.addChild(this.regulators[i] = new SoundRegulator(i, binder));
			
			
			var quit:Button = createButton("BACK");
			quit.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			this.addChild(quit);
		}
		
		public function setSoundMute(type:int, value:Boolean):void
		{
			this.regulators[type].checkBox.isSelected = !value;
		}
		
		public function setSoundVolume(type:int, value:Number):void
		{
			this.regulators[type].slider.value = value * SoundRegulator.SLIDER_MAXIMUM;
		}
		
		
		private function handleQuitTriggered():void
		{
			this.dispatchEventWith(ShellEvent.SHOW_MAIN);
		}
	}

}