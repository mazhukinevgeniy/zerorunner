package game.actors.modules.pull 
{
	import game.actors.core.ActorBase;
	
	internal class Turret extends ActorBase
	{
		private static const MOVE_SPEED:int = 70000;
		
		public function Turret() 
		{
			const HP:int = 70; //TODO: calculate
			const ACTION_SPEED:int = 2; //TODO: calculate
			
			
			super(HP, Turret.MOVE_SPEED, ACTION_SPEED);
		}
		
	}

}