package ui.sounds 
{
	import feathers.controls.Button;
	import flash.ui.Keyboard;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import ui.themes.ExtendedTheme;
	import utils.SaveBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Sounds extends SaveBase
	{
		private var music:MusicManager;
		private var sound:SoundManager;
		
		private var muteButton:Button;
		
		public function Sounds(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.initializationSoundsManagers(assets);
			this.initializationMuteButton(root);
			this.initializationUsingFlow(flow);
			
			super();
		}
		
		private function initializationSoundsManagers(assets:AssetManager):void
		{
			this.music = new MusicManager(assets);
			this.sound = new SoundManager(assets);
			
			this.music.playMusic();
		}
		
		private function initializationMuteButton(root:DisplayObjectContainer):void
		{
			this.muteButton = new Button();
			this.muteButton.nameList.add(ExtendedTheme.MUTE_BUTTON);
			root.addChild(this.muteButton);
			
			this.muteButton.x = Main.WIDTH - this.muteButton.width;
			this.muteButton.y = Main.HEIGHT - this.muteButton.height;
			
			this.muteButton.addEventListener(Event.TRIGGERED, this.toggleMute);
		}
		
		private function initializationUsingFlow(flow:IUpdateDispatcher):void
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.keyUp);
		}
		
		override protected function checkLocalSave():void
		{
			if (this.localSave.data.sound == null)
			{
				this.localSave.data.sound = new Object();
				this.localSave.data.sound.muted = false;
			}
			
			if (this.localSave.data.sound.muted)
			{
				this.toggleMute();
				this.localSave.data.sound.muted = true;
			}
		}
		
		private function toggleMute():void
		{
			this.music.toggleSound();
			this.sound.toggleSound();
			this.toggleTitleMuteButton();
			
			this.localSave.data.sound.muted = !this.localSave.data.sound.muted;
		}
		
		private function toggleTitleMuteButton():void
		{
			if (this.muteButton.label == "Mute")
			{
				this.muteButton.label = "Unmute";
			}
			else
			{
				this.muteButton.label = "Mute";
			}
		}
		
		update function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.M)
				this.toggleMute();
		}
	}

}