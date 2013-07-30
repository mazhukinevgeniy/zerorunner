package ui.sounds 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.utils.SaveBase;
	import flash.ui.Keyboard;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import ui.ChaoticUI;
	
	public class Sounds extends SaveBase
	{
		private var music:MusicManager;
		private var sound:SoundManager;
		
		private var muteButton:MuteButton;
		
		public function Sounds(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(ChaoticUI.keyUp);
			
			this.music = new MusicManager(assets);
			this.sound = new SoundManager(assets);
			
			this.music.playMusic();
			
			this.muteButton = new MuteButton();
			root.addChild(this.muteButton);
			this.muteButton.addEventListener(Event.TRIGGERED, this.toggleMute);
			
			super();
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
			this.muteButton.toggleTitle();
			
			this.localSave.data.sound.muted = !this.localSave.data.sound.muted;
		}
		
		update function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.M)
				this.toggleMute();
		}
	}

}