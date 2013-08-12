package game.actors.types.fog 
{
	import game.actors.types.ActorLogicBase;
	import game.actors.utils.ConfigKit;
	
	internal class FogLogic extends ActorLogicBase
	{
		private static const CONFIG:ConfigKit = new ConfigKit(1, 3, 10000000);
		
		public function FogLogic() 
		{
			super(new FogView());
		}
		
		override protected function onPushed():void
		{
			this.applyDestruction();
		}
		
		
		override protected function getConfig():ConfigKit
		{
			return FogLogic.CONFIG;
		}
	}

}