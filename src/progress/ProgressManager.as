package progress 
{
	import game.ZeroRunner;
	import progress.achievements.AchievementSave;
	import progress.statistics.StatisticSave;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ProgressManager
	{
		
		private var activeAchievements:Vector.<int>;
		
		private var statistics:StatisticSave;
		private var achievements:AchievementSave;
		
		public function ProgressManager(flow:IUpdateDispatcher) 
		{
			this.activeAchievements = new Vector.<int>();
			
			this.statistics = new StatisticSave(flow);
			this.achievements = new AchievementSave();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.freeFrame);
		}
		
		update function freeFrame(frame:int):void
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
		
	}

}