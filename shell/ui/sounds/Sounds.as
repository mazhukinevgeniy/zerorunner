package ui.sounds 
{
	import chaotic.core.IUpdateDispatcher;
	import flash.ui.Keyboard;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import ui.ChaoticUI;
	
	public class Sounds 
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
		}
		
		public function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.M)
			{
				this.music.toggleSound();
				this.sound.toggleSound();
				this.muteButton.toggleTitle();
			}
		}
	}

}