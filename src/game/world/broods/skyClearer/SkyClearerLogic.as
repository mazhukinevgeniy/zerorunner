package game.world.broods.skyClearer 
{
	import game.utils.GameFoundations;
	import game.utils.metric.CellXY;
	import game.utils.metric.DCellXY;
	import game.world.broods.ISolderable;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.IWindBound;
	
	public class SkyClearerLogic extends ItemLogicBase implements ISolderable
	{
		internal static const MAXIMUM_CONSTRUCTION:int = 50;
		
		private static const changes:Vector.<DCellXY> = new <DCellXY>
			[new DCellXY(0, 1), new DCellXY( -1, 0), new DCellXY(1, 0), new DCellXY(0, -1),
			 new DCellXY(1, 1), new DCellXY( -1, 1), new DCellXY(1, -1), new DCellXY( -1, -1)];
		
		private var view:SkyClearerView;
		
		public function SkyClearerLogic(foundations:GameFoundations) 
		{
			super(this.view = new SkyClearerView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			var cell:CellXY = super.getSpawningCell();
			
			while (this.world.getSceneCell(cell.x, cell.y) == Game.FALL)
				cell = super.getSpawningCell();
			
			return cell;
		}
		
		override public function act():void 
		{ 
			var change:DCellXY;
			var actor:ItemLogicBase;
			var i:int;
			
			if (this.constructionStatus > SkyClearerLogic.MAXIMUM_CONSTRUCTION / 2)
			{
				for (i = 0; i < 8; i++)
				{
					change = SkyClearerLogic.changes[i];
					
					actor = this.world.findObjectByCell(this.x + change.x, this.y + change.y);
					if (actor && actor is IWindBound)
						(actor as IWindBound).applyWind(change);
				}
			}
		}
		
		
		
		private var constructionStatus:int;
		
		public function get progress():Number
		{
			return Number(this.constructionStatus / SkyClearerLogic.MAXIMUM_CONSTRUCTION);
		}
		
		override protected function reset():void
		{
			super.reset();
			
			this.constructionStatus = Math.random() * SkyClearerLogic.MAXIMUM_CONSTRUCTION * 0.7;
			this.view.showConstruction(this.constructionStatus);
		}
		
		public function applySoldering(value:int):void
		{
			this.constructionStatus += value;
			this.view.showConstruction(this.constructionStatus);
			
			if (this.constructionStatus >= 2 * SkyClearerLogic.MAXIMUM_CONSTRUCTION)
			{
				this.applyDestruction();
			}
		}
	}

}