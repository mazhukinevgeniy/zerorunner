package view.shell.settings 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Slider;
	import starling.display.Sprite;
	import starling.events.Event;
	import view.themes.ShellTheme;

	public class VolumeController extends Sprite
	{
		private static const GAP:int = 30;
		
		public var slider:Slider;
		
		public var label:Label;
		//TODO: replace with icon asap
		
		private var toggleButton:Button;
		
		public function VolumeController(name:String) 
		{
			this.toggleButton = new Button();
			this.toggleButton.nameList.add(name);
			this.toggleButton.nameList.add(ShellTheme.TOGGLE_MUTE);
			
			this.slider = new Slider();
			
			this.label = new Label();
			
			
			this.addChild(this.toggleButton);
			this.addChild(this.slider);
			this.addChild(this.label);

			this.addEventListener(Event.ADDED_TO_STAGE, this.locate);
			
			this.slider.value = this.slider.maximum = 100;
			//TODO: get from save
		}
		
		private function locate(event:Event):void
		{
			this.slider.x = this.toggleButton.width + VolumeController.GAP;
			//TODO: use layout instead
			this.slider.y = (this.height - slider.height) / 2;
			this.label.x = this.slider.x + this.slider.width + VolumeController.GAP;
		}
		
	}

}