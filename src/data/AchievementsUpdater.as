package data 
{
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class AchievementsUpdater 
	{
		private var save:SharedObjectManager;
		
		public function AchievementsUpdater(flow:IUpdateDispatcher, save:SharedObjectManager) 
		{
			this.save = save;
			
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
	}

}