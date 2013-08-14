package game.items.skyClearer 
{
	import game.items.ItemLogicBase;
	import game.items.utils.ConfigKit;
	
	internal class SkyClearerLogic extends ItemLogicBase
	{
		
		public function SkyClearerLogic() 
		{
			super(new SkyClearerView());
		}
		
		
		
		/**
		 * Tower core
		 */
		
		final override protected function getConfig():ConfigKit
		{
			return new ConfigKit(10000000, 10000000, 0);;
		}
		
		final override protected function onCanMove():void
		{
			
		}
		
		final override protected function onSoldered(solderer:ItemLogicBase):void
		{
			//TODO: change local condition and set solderer soldering
		}
		
		/**
		 * Tower core END
		 */
	}

}