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
					["soundVolume", [1, 1]]
				];
			
			var length:int = properties.length;
			
			for each (var property:Array in properties)
			{
				if (!this.so.data.hasOwnProperty(property[0]) ||
				    (property[1] is Array && !(this.so.data[property[0]] is Array)))
					this.so.data[property[0]] = property[1];
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