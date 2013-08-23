package game.world.broods.fog 
{
	import game.utils.GameFoundations;
	import game.utils.metric.DCellXY;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.ConfigKit;
	
	public class FogLogic extends ItemLogicBase
	{
		
		public function FogLogic(foundations:GameFoundations) 
		{
			super(new FogView(foundations), foundations);
		}
		
		
		
		
		protected function onPushed():void
		{
			this.applyDestruction();
		}
		
		
		/**
		 * Cloud core
		 */
		
		final override protected function getConfig():ConfigKit
		{
			return ConfigKit.CLOUD;
		}
		
		protected function onWind(change:DCellXY):void
		{
			this.move(change);
		}
		
		/**
		 * Cloud core END
		 */
	}

}