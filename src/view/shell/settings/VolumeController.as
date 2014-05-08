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
		
		private var slider:Slider;
		private var button:Button;
		private var label:Label;
		
		public function VolumeController(name:String) 
		{		
			this.button = new Button();
			this.button.nameList.add(ShellTheme.SOUND_SETTING);
			
			this.slider = new Slider();
			
			this.label = new Label();
			if(name == ShellTheme.SOUND_SETTING)
				this.label.text = "Sound";
			else if (name == ShellTheme.MUSIC_SETTING)
				this.label.text = "Music";
				
			this.addChild(this.button);
			this.addChild(this.slider);
			this.addChild(this.label);

			this.addEventListener(Event.ADDED_TO_STAGE, this.locate);
			
			this.slider.value = this.slider.maximum = 100;
			//TODO: get from save
			
			this.slider.addEventListener(Event.CHANGE, this.changeHandler);
			
			this.name = name;
		}
		
		private function locate(event:Event):void
		{
			this.slider.x = this.button.width + VolumeController.GAP;
			this.slider.y = (this.height - slider.height) / 2;
			this.label.x = this.slider.x + this.slider.width + VolumeController.GAP;
		}
		
		private function changeHandler(event:Event):void
		{
			var slider:Slider = Slider(event.currentTarget);
			//this.flow.dispatchUpdate(Update.changeVolume, this.name, slider.value / 100);
			//TODO: improve soundController
		}
		
	}

}