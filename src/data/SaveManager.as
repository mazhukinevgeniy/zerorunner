package data 
{
	import data.structs.AchievementInfo;
	import flash.net.SharedObject;
	import game.ZeroRunner;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class SaveManager //TODO: rename
	{
		protected var localSave:SharedObject;
		
		private var activeAchievements:Vector.<int>;
		
		
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
		
		public function get numberOfAchievements():int
		{
			return 0;
		}
		
		public function getAchievement(id:int):AchievementInfo
		{
			return new AchievementInfo();
		}
	}

}