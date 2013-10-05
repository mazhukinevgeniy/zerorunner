package ui.navigation 
{
	import feathers.controls.Button;
	import flash.ui.Keyboard;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class MuteButton extends Sprite
	{	
		private var flow:IUpdateDispatcher;
		
		private var button:Button;
		
		public function MuteButton(flow:IUpdateDispatcher) 
		{
			super();
			
			this.button = new Button();
			this.button.nameList.add(ExtendedTheme.MUTE_BUTTON);
			this.addChild(this.button);
			
			this.button.addEventListener(Event.TRIGGERED, this.toggleMute);
			this.button.addEventListener(Event.ADDED_TO_STAGE, this.locate);
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.keyUp);
		}
		
		private function locate(event:Event):void
		{
			this.x = Main.WIDTH - this.button.width;
			this.y = Main.HEIGHT - this.button.height;
		}
		
		private function toggleMute(event:Event):void
		{
			this.flow.dispatchUpdate(Update.toggleMute);
			this.toggleTitleMuteButton();
		}
		
		private function toggleTitleMuteButton():void
		{
			if (this.button.label == "Mute")
			{
				this.button.label = "Unmute";
			}
			else
			{
				this.button.label = "Mute";
			}
		}
		
		update function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.M)
				this.toggleTitleMuteButton();
		}
		
	}

}