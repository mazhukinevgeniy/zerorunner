package game.world.items.fog 
{
	import game.core.GameFoundations;
	import game.core.metric.*;
	import game.world.items.IPushable;
	import game.world.items.ItemLogicBase;
	import game.world.items.IWindBound;
	import game.world.operators.ClearFeature;
	
	public class FogLogic extends ItemLogicBase implements IPushable, IWindBound
	{
		private const MOVE_SPEED:int = 0;
		
		public function FogLogic(foundations:GameFoundations) 
		{
			super(new FogView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			var width:int = ((this.game).mapWidth + 2) * Game.SECTOR_WIDTH - 2 * ClearFeature.CLEAR_RANGE;
			var cell:CellXY = Metric.getTmpCell(ClearFeature.CLEAR_RANGE + Math.random() * width, ClearFeature.CLEAR_RANGE + Math.random() * width);
			
			for (; this.world.findObjectByCell(cell.x, cell.y); )
				cell.setValue(ClearFeature.CLEAR_RANGE + Math.random() * width, ClearFeature.CLEAR_RANGE + Math.random() * width);
			
			return cell;
		}
		
		
		public function applyWind(change:DCellXY):void
		{
			if (this.world.findObjectByCell(this.x + change.x, this.y + change.y))
				this.applyDestruction();
			else
				this.move(change, this.MOVE_SPEED);
		}
	}

}