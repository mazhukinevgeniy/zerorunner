package view.shell.controls 
{
	import feathers.controls.Check;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Slider;
	import feathers.layout.HorizontalLayout;
	import view.themes.ShellTheme;

	public class SoundRegulator extends LayoutGroup
	{
		private static const GAP:int = 30;
		
		public var slider:Slider;
		
		public var checkBox:Check;
		
		public function SoundRegulator(name:String) 
		{
			this.setLayout();
			
			
			this.checkBox = new Check();
			this.checkBox.nameList.add(name);
			this.checkBox.nameList.add(ShellTheme.TOGGLE_MUTE);
			
			this.slider = new Slider();
			
			this.addChild(this.checkBox);
			this.addChild(this.slider);
			
			this.slider.value = this.slider.maximum = 100;
			//TODO: get from save
		}
		
		private function setLayout():void
		{
			var layout:HorizontalLayout = new HorizontalLayout();
			
			layout.gap = 26;
			
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			
			this.layout = layout;
		}
		
	}

}