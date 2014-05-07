package view.shell.windows.settings 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Slider;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.Theme;
	import utils.updates.IUpdateDispatcher;

	public class VolumeController extends Sprite
	{
		private static const GAP:int = 30;
		
		private var slider:Slider;
		private var button:Button;
		private var label:Label;
		
		private var flow:IUpdateDispatcher;
		
		public function VolumeController(name:String, flow:IUpdateDispatcher) 
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

			this.addEventListener(Event.ADDED_TO_STAGE, this.locate);
			
			this.slider.value = this.slider.maximum = 100;
			//TODO: get from save
			
			this.slider.addEventListener(Event.CHANGE, this.changeHandler);
			
			this.name = name;
			this.flow = flow;
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
			this.flow.dispatchUpdate(Update.changeVolume, this.name, slider.value / 100);
		}
		
	}

}