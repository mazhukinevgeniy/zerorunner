package game.actors.modules.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.core.ActorBase;
	
	internal class Robot extends ActorBase
	{
		
		
		public function Robot() 
		{
			const HP:int = 70; //TODO: calculate
			const ACTION_SPEED:int = 20; //TODO: calculate
			const MOVE_SPEED:int = 10; 
			
			
			super(HP, MOVE_SPEED, ACTION_SPEED);
		}
		
		
		override protected function onSpawned(id:int):void
		{
			this.listener.actorSpawned(id, this.giveCell(), ActorsFeature.ROBOT);
		}
	}

}