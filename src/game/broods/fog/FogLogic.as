package game.broods.fog 
{
	import game.broods.ItemLogicBase;
	import game.broods.utils.ConfigKit;
	import game.utils.metric.DCellXY;
	
	internal class FogLogic extends ItemLogicBase
	{
		
		public function FogLogic() 
		{
			super(new FogView());
		}
		
		
		
		
		override protected function onPushed():void
		{
			this.applyDestruction();
		}
		
		override protected function onBlocked(change:DCellXY):void
		{
			this.applyPush();
		}
		
		
		/**
		 * Cloud core
		 */
		
		final override protected function getConfig():ConfigKit
		{
			return ConfigKit.CLOUD;
		}
		
		final override protected function onWind(change:DCellXY):void
		{
			this.move(change);
		}
		
		/**
		 * Cloud core END
		 */
	}

}