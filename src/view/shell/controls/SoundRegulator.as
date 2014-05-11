package view.shell.controls 
{
	import binding.IBinder;
	import controller.interfaces.ISoundController;
	import feathers.controls.Check;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Slider;
	import feathers.layout.HorizontalLayout;
	import model.interfaces.ISave;
	import starling.events.Event;
	import view.themes.ShellTheme;

	public class SoundRegulator extends LayoutGroup
	{
		public var slider:Slider;
		public var checkBox:Check;
		
		private var soundType:int;
		
		private var soundController:ISoundController;
		
		public function SoundRegulator(type:int, binder:IBinder) 
		{
			this.soundType = type;
			this.soundController = binder.soundController;
			
			this.setLayout();
			
			var save:ISave = binder.save;
			
			this.checkBox = new Check();
			this.checkBox.nameList.add(ShellTheme.SOUND[type]);
			this.checkBox.nameList.add(ShellTheme.TOGGLE_MUTE);
			
			this.checkBox.isSelected = !save.getSoundMute(this.soundType);
			
			
			this.slider = new Slider();
			this.slider.maximum = 100;
			
			this.slider.value = 100 * save.getSoundValue(this.soundType);
			
			
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
			this.soundController.setSoundValue(this.soundType, this.slider.value / this.slider.maximum);
		}
		private function handleCheckChange():void
		{
			this.soundController.setSoundMute(this.soundType, !this.checkBox.isSelected);
		}
	}

}