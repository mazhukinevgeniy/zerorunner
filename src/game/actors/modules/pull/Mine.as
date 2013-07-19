package game.actors.modules.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.core.ActorBase;
	
	internal class Mine extends ActorBase
	{
		private static const HP:int = 1;
		private static const MOVE_SPEED:int = 7;
		private static const ACTION_SPEED:int = 300;
		
		public function Mine() 
		{
			super(Mine.HP, Mine.MOVE_SPEED, Mine.ACTION_SPEED);
		}
		
		override protected function onSpawned(id:int):void
		{
			this.listener.actorSpawned(id, this.giveCell(), ActorsFeature.MINE);
		}
		
	}

}