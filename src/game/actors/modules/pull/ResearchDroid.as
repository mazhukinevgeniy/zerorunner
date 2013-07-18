package game.actors.modules.pull 
{
	import game.actors.core.ActorBase;
	
	internal class ResearchDroid extends ActorBase
	{
		private static const HP:int = 10;
		private static const MOVE_SPEED:int = 3;
		private static const ACTION_SPEED:int = 400;
		
		public function ResearchDroid() 
		{
			super(ResearchDroid.HP, ResearchDroid.MOVE_SPEED, ResearchDroid.ACTION_SPEED);
		}
		
	}

}