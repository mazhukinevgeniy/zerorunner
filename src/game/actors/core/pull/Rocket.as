package game.actors.core.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.core.ActorBase;
	
	
	internal class Rocket extends ActorBase 
	{
		
		public function Rocket() 
		{
			super(100, 1000, 10);
		}
		
		
		
		override public function getClassCode():int
		{
			return ActorsFeature.ROCKET;
		}
	}

}