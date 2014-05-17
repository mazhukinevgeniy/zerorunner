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
			
			const entries:XMLList = SaveXML.getOne().entry;
			
			if (!this.so.data.hasOwnProperty("version") ||
				!this.so.data.version.hasOwnProperty("0") ||
				this.so.data.version[0] != entries[0].@value)
				this.so.clear();
			
			this.addEntries(entries);
			
			binder.notifier.addObserver(this);
		}
		
		private function addEntries(entries:XMLList):void
		{
			var length:int = entries.length();
			var root:Object = this.so.data;
			
			for (var i:int = 0; i < length; i++)
			{
				var entry:XML = entries[i];
				
				var name:String = entry.@name;
				var value:String = entry.@value;
				
				var type:int = entry.@type.length() ? entry.@type : 0;
				
				
				if (!root.hasOwnProperty(name))
				{
					root[name] = { };
				}
				
				if (!root[name].hasOwnProperty(type))
				{
					root[name][type] = value;
				}
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
		
		public function getCollectibleFound(type:int):Boolean
		{
			return this.so.data.collectible[type];
		}
	}

}