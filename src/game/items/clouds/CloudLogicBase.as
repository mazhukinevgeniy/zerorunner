package game.items.clouds 
{
	import game.items.ActorLogicBase;
	import game.items.ActorViewBase;
	import game.items.utils.ConfigKit;
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
		
		final override protected function onCanMove():void
		{
			
		}
		
		
		
		
		final internal function applyMove(change:DCellXY):void
		{
			this.move(change);
		}
	}

}