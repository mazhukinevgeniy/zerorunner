package game.items.skyClearer 
{
	import game.items.ItemLogicBase;
	import game.items.utils.ConfigKit;
	import game.metric.DCellXY;
	
	internal class SkyClearerLogic extends ItemLogicBase
	{
		internal static const MAXIMUM_CONSTRUCTION:int = 50;
		
		private static const changes:Vector.<DCellXY> = new <DCellXY>
			[new DCellXY(0, 1), new DCellXY( -1, 0), new DCellXY(1, 0), new DCellXY(0, -1),
			 new DCellXY(1, 1), new DCellXY( -1, 1), new DCellXY(1, -1), new DCellXY( -1, -1)];
		
		private static const config:ConfigKit = new ConfigKit(50, 10000000, 0);
		
		private var view:SkyClearerView;
		
		public function SkyClearerLogic() 
		{
			super(this.view = new SkyClearerView());
		}
		
		override protected function onCanAct():void 
		{ 
			var change:DCellXY;
			var actor:ItemLogicBase;
			var i:int;
			
			if (this.constructionStatus > SkyClearerLogic.MAXIMUM_CONSTRUCTION)
			{
				for (i = 0; i < 8; i++)
				{
					change = SkyClearerLogic.changes[i];
					
					actor = this.world.findObjectByCell(this.x + change.x, this.y + change.y);
					if (actor)
						actor.applyWind(change);
					
					actor = this.world.findObjectByCell(this.x + 2 * change.x, this.y + 2 * change.y);
					if (actor)
						actor.applyWind(change);
				}
			}
			else if (this.constructionStatus > SkyClearerLogic.MAXIMUM_CONSTRUCTION / 2)
			{
				for (i = 0; i < 8; i++)
				{
					change = SkyClearerLogic.changes[i];
					
					actor = this.world.findObjectByCell(this.x + change.x, this.y + change.y);
					if (actor)
						actor.applyWind(change);
				}
			}
		}
		
		/**
		 * Tower core
		 */
		
		private var constructionStatus:int;
		
		override protected function onSpawned():void
		{
			this.constructionStatus = Math.random() * SkyClearerLogic.MAXIMUM_CONSTRUCTION * 0.7;
			this.view.showConstruction(this.constructionStatus);
		}
		
		override protected function getConfig():ConfigKit
		{
			return SkyClearerLogic.config;
		}
		
		override protected function onSoldered(solderer:ItemLogicBase, value:int):void
		{
			if (this.constructionStatus <= SkyClearerLogic.MAXIMUM_CONSTRUCTION)
			{
				this.constructionStatus += value;
				if (this.constructionStatus > SkyClearerLogic.MAXIMUM_CONSTRUCTION / 2)
					solderer.basicSolderingSucceed();
				
				this.view.showConstruction(this.constructionStatus);
			}
			else
			{
				this.applyDamage(value);
			}
			
			solderer.applyModeSoldering(this);
		}
		
		/**
		 * Tower core END
		 */
	}

}