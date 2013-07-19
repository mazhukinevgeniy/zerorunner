package game.actors.modules.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.core.ActorBase;
	
	internal class Mechanic extends ActorBase
	{
		private static const HP:int = 15;
		private static const MOVE_SPEED:int = 4;
		private static const ACTION_SPEED:int = 3;
		
		public function Mechanic() 
		{
			super(Mechanic.HP, Mechanic.MOVE_SPEED, Mechanic.ACTION_SPEED);
		}
		
		override protected function onSpawned(id:int):void
		{
			this.listener.actorSpawned(id, this.giveCell(), ActorsFeature.MECHANIC);
		}
		
	}

}