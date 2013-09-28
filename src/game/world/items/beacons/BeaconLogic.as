package game.world.items.beacons 
{
	import game.core.GameFoundations;
	import game.core.metric.*;
	import game.world.items.ISolderable;
	import game.world.items.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	
	public class BeaconLogic extends ItemLogicBase implements ISolderable
	{
		private const MAXIMUM_CONSTRUCTION:int = 250;
		
		private var flow:IUpdateDispatcher;
		private var view:BeaconView;
		
		public function BeaconLogic(foundations:GameFoundations) 
		{
			this.flow = foundations.flow;
			
			super(this.view = new BeaconView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return Metric.getTmpCell(Game.SECTOR_WIDTH * (1 + (this.game).mapWidth) - 1, Game.SECTOR_WIDTH);
		}
		
		
		private var constructionStatus:int;
		
		public function get progress():Number
		{
			return Number(this.constructionStatus / this.MAXIMUM_CONSTRUCTION);
		}
		
		override protected function reset():void
		{
			super.reset();
			
			this.constructionStatus = 0;
			this.view.showConstruction(this.constructionStatus / this.MAXIMUM_CONSTRUCTION);
		}
		
		public function applySoldering(value:int):void
		{
			this.constructionStatus += value;
			this.view.showConstruction(this.constructionStatus / this.MAXIMUM_CONSTRUCTION);
			
			if (this.constructionStatus > this.MAXIMUM_CONSTRUCTION)
			{
				this.flow.dispatchUpdate(Update.gameWon);
			}
		}
	}

}