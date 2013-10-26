package data.updaters 
{
	import data.Defaults;
	import flash.geom.Point;
	import flash.utils.Proxy;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class AchievementsUpdater 
	{
		private var save:Proxy;
		
		public function AchievementsUpdater(flow:IUpdateDispatcher, save:Proxy) 
		{
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.numberedFrame);
			flow.addUpdateListener(Update.createAchievements);
			flow.addUpdateListener(Update.resetProgress);
		}
		
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				/*
				var length:int = this.activeAchievements.length;
				
				for (var i:int = 0; i < length; i++)
				{
					this.activeAchievements[i].checkIfUnlocked(this.localSave.data);
				} 
				*/
			}
			
		}
		
		update function createAchievements(data:Vector.<Point>):void
		{
			var id:int = this.save["numberOfAchievements"] + 1;
			this.save["numberOfAchievements"] = id;
			
			this.save[String(id)] = data;			
		}
		
		update function resetProgress():void
		{
			for (var value:String in Defaults.achievementsDefaults)
				this.save[value] = Defaults.achievementsDefaults[value];
		}
	}

}