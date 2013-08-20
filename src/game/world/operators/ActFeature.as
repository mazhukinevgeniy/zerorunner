package game.world.operators 
{
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class ActFeature 
	{
		
		public function ActFeature(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.tick);
		}
		
		update function tick():void
		{
			
		}
	}

}