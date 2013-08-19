package game.world.broods.fog 
{
	import game.utils.GameFoundations;
	import game.utils.metric.DCellXY;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.ConfigKit;
	import game.world.ISearcher;
	
	internal class FogLogic extends ItemLogicBase
	{
		
		public function FogLogic(foundations:GameFoundations, world:ISearcher) 
		{
			super(new FogView(foundations), foundations, world);
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