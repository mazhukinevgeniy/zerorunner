package view.shell.controls 
{
	import binding.IBinder;
	import controller.interfaces.ISoundController;
	import feathers.controls.Check;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Slider;
	import feathers.layout.HorizontalLayout;
	import starling.events.Event;
	import view.themes.ShellTheme;

	public class SoundRegulator extends LayoutGroup
	{
		private var slider:Slider;
		private var checkBox:Check;
		
		private var soundType:int;
		
		private var soundController:ISoundController;
		
		public function SoundRegulator(type:int, binder:IBinder) 
		{
			this.soundType = type;
			this.soundController = binder.soundController;
			
			this.setLayout();
			
			this.checkBox = new Check();
			this.checkBox.nameList.add(ShellTheme.SOUND[type]);
			this.checkBox.nameList.add(ShellTheme.TOGGLE_MUTE);
			
			this.slider = new Slider();
			this.slider.value = this.slider.maximum = 100;
			//TODO: get from save
			
			
			this.addChild(this.checkBox);
			this.addChild(this.slider);
			
			this.slider.addEventListener(Event.CHANGE, this.handleSliderChange);
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
	}

}