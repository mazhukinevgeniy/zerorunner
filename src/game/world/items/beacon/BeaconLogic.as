package game.world.items.beacon 
{
	import game.core.metric.*;
	import game.GameElements;
	import game.world.items.ISolderable;
	import game.world.items.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	
	public class BeaconLogic extends ItemLogicBase implements ISolderable
	{
		private const MAXIMUM_CONSTRUCTION:int = 50;
		
		private var flow:IUpdateDispatcher;
		private var view:BeaconView;
		
		private var reported:Boolean;
		
		public function BeaconLogic(foundations:GameElements) 
		{
			this.flow = foundations.flow;
			
			super(this.view = new BeaconView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return Metric.getTmpCell(Game.BORDER_WIDTH + this.config.width - 1, Game.BORDER_WIDTH);
		}
		
		
		private var constructionStatus:int;
		
		public function get progress():Number
		{
			return Number(this.constructionStatus / this.MAXIMUM_CONSTRUCTION);
		}
		
		override protected function reset():void
		{
			super.reset();
			
			this.reported = false;
			
			this.constructionStatus = 0;
			this.view.showConstruction(this.constructionStatus / this.MAXIMUM_CONSTRUCTION);
		}
		
		public function applySoldering(value:int):void
		{
			this.constructionStatus += value;
			this.view.showConstruction(this.constructionStatus / this.MAXIMUM_CONSTRUCTION);
			
			if (this.constructionStatus > this.MAXIMUM_CONSTRUCTION && !this.reported)
			{
				this.reported = true;
				this.flow.dispatchUpdate(Update.smallBeaconTurnedOn);
			}
		}
	}

}