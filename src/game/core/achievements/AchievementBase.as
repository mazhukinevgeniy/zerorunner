package game.core.achievements 
{
	
	public class AchievementBase
	{		
		private var locked:Boolean = true;
		private var next:Vector.<AchievementBase>;
		
		public function AchievementBase() 
		{
			
		}
		
		internal function checkIfUnlocked(data:Object):void
		{
			
		}
		
		public function get unlocked():Boolean
		{
			return !this.locked;
		}
	}

}