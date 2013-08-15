package game.items.skyClearer 
{
	import game.items.ItemLogicBase;
	import game.items.utils.ConfigKit;
	import game.metric.DCellXY;
	
	internal class SkyClearerLogic extends ItemLogicBase
	{
		private static const changes:Vector.<DCellXY> = new <DCellXY>
			[new DCellXY(0, 1), new DCellXY( -1, 0), new DCellXY(1, 0), new DCellXY(0, -1),
			 new DCellXY(1, 1), new DCellXY(-1, 1), new DCellXY(1, -1), new DCellXY(-1, -1)];
		
		public function SkyClearerLogic() 
		{
			super(new SkyClearerView());
		}
		
		override protected function onCanAct():void 
		{ 
			var change:DCellXY;
			var actor:ItemLogicBase;
			
			for (var i:int = 0; i < 8; i++)
			{
				change = SkyClearerLogic.changes[i];
				
				actor = this.world.findObjectByCell(this.x + change.x, this.y + change.y);
				if (actor)
					actor.applyWind(change);
			}
		}
		
		/**
		 * Tower core
		 */
		
		private var constructionStatus:int;
		
		override protected function onSpawned():void
		{
			this.constructionStatus = 0;
		}
		
		override protected function getConfig():ConfigKit
		{
			return new ConfigKit(10000000, 10000000, 0);;
		}
		
		override protected function onSoldered(solderer:ItemLogicBase, value:int):void
		{
			this.constructionStatus += value;
			
			solderer.applyModeSoldering(this);
			
			//TODO: change local condition and set solderer soldering
		}
		
		/**
		 * Tower core END
		 */
	}

}