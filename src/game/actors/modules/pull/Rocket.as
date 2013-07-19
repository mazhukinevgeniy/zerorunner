package game.actors.modules.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.core.ActorBase;
	
	
	internal class Rocket extends ActorBase 
	{
		
		public function Rocket() 
		{
			super(100, 1000, 10);
		}
		
		
		override protected function onSpawned(id:int):void
		{
			this.listener.actorSpawned(id, this.giveCell(), ActorsFeature.ROCKET);
		}
	}

}