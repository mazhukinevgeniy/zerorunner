package data.updaters 
{
	import data.Defaults;
	import flash.geom.Point;
	import flash.utils.Proxy;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class AchievementsUpdater 
	{
		private static const TEST_TYPE:int = 0;
		
		private static const ADDRESSES:Vector.<String> = new < String > ["distance"];
		
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
				var number:int = this.save["achievements"].length;
				var achievementData:Vector.<Object>;
				var lenghtData:int;
				
				for (var i:int = 0; i < number; ++i)
				{
					achievementData = this.save["achievements"][i];
					lenghtData = achievementData.length;
					for (var j:int = 0; j < lenghtData; ++j)
						if (this.save[AchievementsUpdater.ADDRESSES[achievementData[j].x]] >= achievementData[j].y)
							achievementData.splice(j, 1);
							
					if (achievementData.length == 0)
					{
						this.save["achievements"].splice(i, 1);
						trace("achievement complete");
					}
				}
				/*
				var length:int = this.activeAchievements.length;
				
				for (var i:int = 0; i < length; i++)
				{
					this.activeAchievements[i].checkIfUnlocked(this.localSave.achievementData);
				} 
				*/
			}
			
		}
		
		update function openedAchievement(numberOfNew:int):void
		{
			var achievementData:Vector.<Object>;
			var type:int = AchievementsUpdater.TEST_TYPE;
			var condition:int = 20;
			var id:int = this.save["achievements"].length;
			
			for (var i:int = 0; i < numberOfNew; ++i, ++id)
			{
				achievementData = new <Object>[new Point(type, condition)];
				
				this.save["achievements"].push(achievementData);			
			}
		}
		
		update function resetProgress():void
		{
			for (var value:String in Defaults.achievementsDefaults)
				this.save[value] = Defaults.achievementsDefaults[value];
		}
	}

}