package view.shell 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	import structs.SoundMute;
	import structs.SoundVolume;
	import view.shell.controls.SoundRegulator;
	import view.shell.events.ShellEvent;
	import view.themes.ShellTheme;
	import view.utils.createButton;
	
	
	internal class OptionsScreen extends Screen
	{
		private var regulators:Vector.<SoundRegulator>;
		
		public function OptionsScreen(binder:IBinder) 
		{
			super();
			
			binder.eventDispatcher.addEventListener(GlobalEvent.SET_SOUND_MUTE,
			                                        this.setSoundMute);
			binder.eventDispatcher.addEventListener(GlobalEvent.SET_SOUND_VOLUME,
			                                        this.setSoundVolume);
			
			this.regulators = new Vector.<SoundRegulator>(View.NUMBER_OF_SOUND_TYPES, true);
			
			for (var i:int = 0; i < View.NUMBER_OF_SOUND_TYPES; i++)
				this.addChild(this.regulators[i] = new SoundRegulator(i, binder));
			
			
			var quit:Button = createButton("BACK", ShellTheme.NAVIGATION_BUTTON);
			quit.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			this.addChild(quit);
		}
		
		private function setSoundMute(event:Event, mute:SoundMute):void
		{
			this.regulators[mute.type].checkBox.isSelected = !mute.value;
		}
		
		private function setSoundVolume(event:Event, volume:SoundVolume):void
		{
			this.regulators[volume.type].slider.value = 
				volume.value * SoundRegulator.SLIDER_MAXIMUM;
		}
		
		
		private function handleQuitTriggered():void
		{
			this.dispatchEventWith(ShellEvent.SHOW_MAIN);
		}
	}

}