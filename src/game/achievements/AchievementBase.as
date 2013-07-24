package game.achievements 
{
	
	public class AchievementBase
	{		
		private var locked:Boolean = true;
		private var next:Vector.<AchievementBase>;
		
		public function AchievementBase() 
		{
			//TODO: add data and cool stuff
			
			//TODO: add ids
		}
		
		internal function checkIfUnlocked(data:Object):void
		{
			//TODO: check and, if required, generate this.next and do something like dispatching updates
		}
		
		public function get unlocked():Boolean
		{
			return !this.locked;
		}
		//TODO: add more getters
	}

}