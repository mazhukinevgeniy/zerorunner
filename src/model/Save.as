package model 
{
	import assets.xml.SaveXML;
	import binding.IBinder;
	import controller.interfaces.INotifier;
	import controller.observers.ISoundObserver;
	import flash.net.SharedObject;
	import model.interfaces.ISave;
	
	public class Save implements ISave,
								 ISoundObserver
	{
		private var so:SharedObject;
		
		public function Save(binder:IBinder) 
		{
			const PROJECT_NAME:String = "zeroRunner";
			this.so = SharedObject.getLocal(PROJECT_NAME);
			
			this.initializeProperties();
			
			binder.notifier.addObserver(this);
		}
		
		private function initializeProperties():void
		{
			const properties:XMLList =
				SaveXML.getOne().properties;
			
			this.initializeSounds(properties);
		}
		
		private function initializeSounds(properties:XMLList):void
		{
			if (!this.so.data.hasOwnProperty("soundMute") ||
			    !(this.so.data.soundMute is Array))
			{
				this.so.data.soundMute = new Array();
				
				this.so.data.soundMute[View.SOUND_EFFECT] = properties.soundEffectMute;
				this.so.data.soundMute[View.SOUND_MUSIC] = properties.soundMusicMute;
			}
			
			if (!this.so.data.hasOwnProperty("soundVolume") ||
			    !(this.so.data.soundVolume is Array))
			{
				this.so.data.soundVolume = new Array();
				
				this.so.data.soundVolume[View.SOUND_EFFECT] = properties.soundEffectVolume;
				this.so.data.soundVolume[View.SOUND_MUSIC] = properties.soundMusicVolume;
			}
		}
		
		
		public function setSoundMute(type:int, value:Boolean):void
		{
			this.so.data.soundMute[type] = value;
		}
		public function getSoundMute(type:int):Boolean
		{
			return this.so.data.soundMute[type];
		}
		
		public function setSoundVolume(type:int, value:Number):void
		{
			this.so.data.soundVolume[type] = value;
		}
		public function getSoundVolume(type:int):Number
		{
			return this.so.data.soundVolume[type];
		}
	}

}