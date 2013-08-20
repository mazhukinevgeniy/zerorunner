package game.world.operators 
{
	import utils.updates.IUpdateDispatcher;
	
	public class ActorOperators 
	{
		
		public function ActorOperators(flow:IUpdateDispatcher) 
		{
			new ActFeature(flow);
			//new WindFeature(flow);
			
			//TODO: implement
		}
		
	}

}