package utils 
{
	import chaotic.utils.SaveBase;
	
	public class AchievementBase extends SaveBase
	{
		private var locked:Boolean = true;
		
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
		
		public function get unlocked():Boolean
		{
			return !this.locked;
		}
		
	}

}