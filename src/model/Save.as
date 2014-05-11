package model 
{
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
			const properties:Array = 
				[
					["soundMute", [false, false]], 
					["setSoundVolume", [1, 1]]
				];
			
			var length:int = properties.length;
			
			for (var i:int = 0; i < length; i++)
			{
				if (!this.so.data.hasOwnProperty(properties[i][0]))
					this.so.data[properties[i][0]] = properties[i][1];
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
			this.so.data.soundValue[type] = value;
		}
		public function getSoundVolume(type:int):Number
		{
			return this.so.data.soundValue[type];
		}
	}

}