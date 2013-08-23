package game.world.broods.fog 
{
	import game.utils.GameFoundations;
	import game.utils.metric.DCellXY;
	import game.world.broods.ItemLogicBase;
	
	public class FogLogic extends ItemLogicBase
	{
		private const MOVE_SPEED:int = 0;
		
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
		
		protected function onWind(change:DCellXY):void
		{
			this.move(change, this.MOVE_SPEED);
		}
		
		/**
		 * Cloud core END
		 */
	}

}