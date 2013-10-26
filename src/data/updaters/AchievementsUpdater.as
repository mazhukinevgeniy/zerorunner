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
			flow.addUpdateListener(Update.openedAchievement);
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
		
		update function openedAchievement(numberOfNew:int):void
		{
			var data:Vector.<Point>;
			var type:int = 0;
			var condition:int = 20;
			var id:int = this.save["numberOfAchievements"];
			
			for (var i:int = 0; i < numberOfNew; ++i, ++id)
			{
				data = new <Point>[new Point(type, condition)];
				
				this.save["numberOfAchievements"]++;
				this.save[String(id)] = data;			
			}
		}
		
		update function resetProgress():void
		{
			for (var value:String in Defaults.achievementsDefaults)
				this.save[value] = Defaults.achievementsDefaults[value];
		}
	}

}