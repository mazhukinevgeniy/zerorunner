package model 
{
	import assets.xml.SaveXML;
	import binding.IBinder;
	import events.GlobalEvent;
	import flash.net.SharedObject;
	import model.collectibles.Collectible;
	import model.interfaces.ISave;
	import starling.events.Event;
	import structs.SoundMute;
	import structs.SoundVolume;
	
	public class Save implements ISave
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
			
			binder.eventDispatcher.addEventListener(GlobalEvent.COLLECTIBLE_FOUND,
			                                        this.collectibleFound);
			binder.eventDispatcher.addEventListener(GlobalEvent.SET_SOUND_MUTE,
			                                        this.setSoundMute);
			binder.eventDispatcher.addEventListener(GlobalEvent.SET_SOUND_VOLUME,
			                                        this.setSoundVolume);
		}
		
		private function addEntries(entries:XMLList):void
		{
			var length:int = entries.length();
			var root:Object = this.so.data;
			
			for (var i:int = 0; i < length; i++)
			{
				var entry:XML = entries[i];
				
				var name:String = entry.@name;
				var value:*;
				
				var dvalue:String = entry.@value;
				if (dvalue == "false")
					value = false;
				else if (dvalue == "true")
					value = true;
				else value = dvalue;
				
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
		
		
		private function setSoundMute(event:Event, mute:SoundMute):void
		{
			this.so.data.soundMute[mute.type] = mute.value;
		}
		public function getSoundMute(type:int):Boolean
		{
			return this.so.data.soundMute[type];
		}
		
		private function setSoundVolume(event:Event, volume:SoundVolume):void
		{
			this.so.data.soundVolume[volume.type] = volume.value;
		}
		public function getSoundVolume(type:int):Number
		{
			return this.so.data.soundVolume[type];
		}
		
		private function collectibleFound(event:Event, collectible:Collectible):void
		{
			this.so.data.collectible[collectible.type] = true;
		}
		public function getCollectibleFound(type:int):Boolean
		{
			return this.so.data.collectible[type];
		}
	}

}