package model 
{
	import controller.observers.ISoundObserver;
	import flash.net.SharedObject;
	
	import model.interfaces.ISave;
	
	public class Save implements ISave,
								 ISoundObserver
	{
		private var so:SharedObject;
		
		public function Save() 
		{
			const PROJECT_NAME:String = "zeroRunner";
			this.so = SharedObject.getLocal(PROJECT_NAME);
			
			this.initializeProperties();
			
		}
		
		private function initializeProperties():void
		{
			const properties:Array = 
				[
					["soundMute", false], 
					["musicMute", false]
				];
			
			var length:int = properties.length;
			
			for (var i:int = 0; i < length; i++)
			{
				if (!this.so.data.hasOwnProperty(properties[i][0]))
					this.so.data[properties[i][0]] = properties[i][1];
			}
		}
		
		public function get soundMute():Boolean { return this.so.data.soundMute; }
		public function setSoundMute(value:Boolean):void { this.so.data.soundMute = value; }
		
		public function get musicMute():Boolean { return this.so.data.musicMute; }
		public function setMusicMute(value:Boolean):void { this.so.data.musicMute = value; }
	}

}