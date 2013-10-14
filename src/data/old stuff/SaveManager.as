package data.old stuff 
{
	import flash.net.SharedObject;
	import game.ZeroRunner;
	import progress.achievements.AchievementSave;
	import progress.achievements.IAchievements;
	import progress.statistics.IStatistic;
	import progress.statistics.StatisticSave;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class SaveManager
	{
		protected var localSave:SharedObject;
		
		
		private var activeAchievements:Vector.<int>;
		
		private var _statistics:StatisticSave;
		private var _achievements:AchievementSave;
		
		public function SaveManager(flow:IUpdateDispatcher) 
		{
			const PROJECT_NAME:String = "zeroRunner";
			
			this.localSave = SharedObject.getLocal(PROJECT_NAME);
			
			
			this.activeAchievements = new Vector.<int>();
			
			this._statistics = new StatisticSave(flow);
			this._achievements = new AchievementSave();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.numberedFrame);
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
		
		public function get statistics():IStatistic
		{
			return this._statistics;
		}
		
		public function get achievements():IAchievements
		{
			return this._achievements;
		}
	}

}