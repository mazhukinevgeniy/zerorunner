package game.actors.types.clouds 
{
	import game.actors.types.ActorLogicBase;
	import game.actors.types.ActorViewBase;
	import game.actors.utils.ConfigKit;
	import game.metric.DCellXY;
	
	public class CloudLogicBase extends ActorLogicBase
	{
		private static const CONFIG:ConfigKit = new ConfigKit(1, 0, 10000000);
		
		public function CloudLogicBase(view:ActorViewBase) 
		{
			super(view);
		}
		
		
		final override protected function getConfig():ConfigKit
		{
			return CloudLogicBase.CONFIG;
		}
		
		
		
		
		final internal function applyMove(change:DCellXY):void
		{
			this.move(change);
		}
	}

}