package view.shell.controls 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import feathers.controls.Check;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Slider;
	import feathers.layout.HorizontalLayout;
	import model.interfaces.ISave;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import structs.SoundMute;
	import structs.SoundVolume;
	import view.themes.ShellTheme;

	public class SoundRegulator extends LayoutGroup
	{
		public static const SLIDER_MAXIMUM:int = 100;
		
		public var slider:Slider;
		public var checkBox:Check;
		
		private var soundType:int;
		
		private var dispatcher:EventDispatcher;
		
		public function SoundRegulator(type:int, binder:IBinder) 
		{
			this.soundType = type;
			this.dispatcher = binder.eventDispatcher;
			
			this.setLayout();
			
			var save:ISave = binder.save;
			
			this.checkBox = new Check();
			this.checkBox.nameList.add(ShellTheme.SOUND[type]);
			this.checkBox.nameList.add(ShellTheme.SOUND_REGULATOR);
			
			this.checkBox.isSelected = !save.getSoundMute(this.soundType);
			
			
			this.slider = new Slider();
			this.slider.nameList.add(ShellTheme.SOUND_REGULATOR);
			
			this.slider.maximum = SoundRegulator.SLIDER_MAXIMUM;
			this.slider.value = SoundRegulator.SLIDER_MAXIMUM * save.getSoundVolume(this.soundType);
			
			
			this.addChild(this.checkBox);
			this.addChild(this.slider);
			
			this.slider.addEventListener(Event.CHANGE, this.handleSliderChange);
			this.checkBox.addEventListener(Event.CHANGE, this.handleCheckChange);
		}
		
		private function setLayout():void
		{
			var layout:HorizontalLayout = new HorizontalLayout();
			
			layout.gap = 26;
			
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			
			this.layout = layout;
		}
		
		
		private function handleSliderChange():void
		{
			this.dispatcher.dispatchEventWith(
				GlobalEvent.SET_SOUND_VOLUME,
			    false,
				new SoundVolume(this.soundType, this.slider.value / this.slider.maximum));
		}
		private function handleCheckChange():void
		{
			this.dispatcher.dispatchEventWith(
				GlobalEvent.SET_SOUND_MUTE,
				false,
				new SoundMute(this.soundType, !this.checkBox.isSelected));
		}
	}

}