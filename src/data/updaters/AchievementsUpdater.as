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
		private static const OPEN:int = 0;
		private static const CLOSED:int = 1;
		
		private static const ADDRESSES:Vector.<String> = new < String > ["distance"];
		
		private var save:Proxy;
		private var openAchievements:Vector.<Vector.<Object>>;
		
		public function AchievementsUpdater(flow:IUpdateDispatcher, save:Proxy) 
		{
			this.save = save;
			
			this.openAchievements = new Vector.<Vector.<Object>>;
			this.initializeOpenAchievements();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.numberedFrame);
			flow.addUpdateListener(Update.openedAchievement);
			flow.addUpdateListener(Update.resetProgress);
		}
		
		private function initializeOpenAchievements():void
		{
			var number:int = this.save["achievements"].length;
			var achievementData:Vector.<Object>;
			var lenghtData:int;
			var lastOpenAchievement:int = -1;
			
			for (var i:int = 0; i < number; ++i)
			{
				achievementData = this.save["achievements"][i];
				if (achievementData[0].y == AchievementsUpdater.OPEN)
				{
					this.openAchievements.push(achievementData);
					lastOpenAchievement++;
					
					lenghtData = achievementData.length;
					for (var j:int = 1; j < lenghtData; ++j)
						if (this.save[AchievementsUpdater.ADDRESSES[achievementData[j].x]] >= achievementData[j].y)
							this.openAchievements[lastOpenAchievement].splice(i, 1);//this.openAchievements[lastOpenAchievement].push(new Point(achievementData[j].x, achievementData[j].y));
				}
			}
		}
		
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				var number:int = this.openAchievements.length;
				var achievementData:Vector.<Object>;
				var lenghtData:int;
				
				for (var i:int = 0; i < number; ++i)
				{
					achievementData = this.openAchievements[i];
					lenghtData = achievementData.length;
					for (var j:int = 1; j < lenghtData; ++j)
						if (this.save[AchievementsUpdater.ADDRESSES[achievementData[j].x]] >= achievementData[j].y)
							achievementData.splice(j, 1);
							
					if (achievementData.length == 1)
					{
						this.closeAchievement(int(achievementData[0].x));
						this.openAchievements.splice(i, 1);
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
				achievementData = new <Object>[new Point(id, AchievementsUpdater.OPEN), new Point(type, condition)];
				
				this.save["achievements"].push(achievementData);
				this.openAchievements.push(achievementData);
			}
		}
		
		private function closeAchievement(id:int):void
		{
			var number:int = this.save["achievements"].length;
			var achievementData:Vector.<Object>;
			
			for (var i:int = 0; i < number; ++i)
			{
				achievementData = this.save["achievements"][i];
				if (achievementData[0].x == id)
					achievementData[0].y = AchievementsUpdater.CLOSED;
			}
		}
		
		update function resetProgress():void
		{
			for (var value:String in Defaults.achievementsDefaults)
				this.save[value] = Defaults.achievementsDefaults[value];
		}
	}

}