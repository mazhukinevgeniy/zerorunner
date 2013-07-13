package game.actors.modules 
{
	import game.actors.core.ActorBase;
	
	public class ActorManipulator
	{
		
		public function ActorManipulator() 
		{
			
		}
		
		public function act(vector:Vector.<ActorBase>):void
		{
			var length:int = vector.length;
			var actor:ActorBase;
			
			for (var i:int = 0; i < length; i++)
			{
				actor = vector[i];
				
				if (actor.active) // TODO: must initialize vector with the maximum number of actors
					actor.act();
			}
		}
		
	}

}