package game.actors.types.checkpoint 
{
	import chaotic.core.IUpdateDispatcher;
	
	public class CheckpointFeature 
	{
		
		public function CheckpointFeature(flow:IUpdateDispatcher) 
		{
			new Spawner(flow);
		}
		
	}

}