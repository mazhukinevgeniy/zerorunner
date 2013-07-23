package game.achievements 
{
	import chaotic.utils.SaveBase;
	
	internal class AchievementBase extends SaveBase
	{
		private var locked:Boolean = true;
		private var next:Vector.<AchievementBase>;
		
		public function AchievementBase() 
		{
			super();
		}
		
		override protected function checkLocalSave():void
		{
			if (!this.localSave.data.achievements)
				this.localSave.data.achievements = new Object();
			/*
			if (!this.localSave.data.achievements.actors)
				this.localSave.data.achievements.actors = new Object();
			
			if (!this.localSave.data.achievements.actors)
				this.localSave.data.achievements.actors = new Object();*/
		}
		
		public function checkIfUnlocked(data:Object):void
		{
			//TODO: check and, if required, do something like dispatching updates
		}
		
		public function get unlocked():Boolean
		{
			return !this.locked;
		}
		
	}

}