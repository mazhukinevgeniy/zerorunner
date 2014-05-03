package ui.windows.settings 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Slider;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.Theme;

	public class VolumeController extends Sprite
	{
		private var slider:Slider;
		private var button:Button;
		private var label:Label;
		
		public function VolumeController(name:String) 
		{		
			this.button = new Button();
			this.button.nameList.add(Theme.SOUND_SETTING);
			
			this.slider = new Slider(); 
			
			this.label = new Label();
			if(name == Theme.SOUND_SETTING)
				this.label.text = "Sound";
			else if (name == Theme.MUSIC_SETTING)
				this.label.text = "Music";
				
			this.addChild(this.button);
			this.addChild(this.slider);
			this.addChild(this.label);

		
			this.slider.addEventListener(Event.CHANGE, this.changeHandler);
		}
		
		private function changeHandler(event:Event):void
		{
			var slider:Slider = Slider(event.currentTarget);
			trace( "slider.value changed:", slider.value);
		}
		
	}

}