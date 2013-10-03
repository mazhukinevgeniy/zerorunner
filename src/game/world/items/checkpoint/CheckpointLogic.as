package game.world.items.checkpoint 
{
	import game.core.GameFoundations;
	import game.core.metric.CellXY;
	import game.core.metric.Metric;
	import game.world.items.ItemLogicBase;
	import utils.updates.update;
	
	public class CheckpointLogic extends ItemLogicBase
	{
		private static var spawnCount:int;
		
		update static function prerestore():void
		{
			CheckpointLogic.spawnCount = 0;
		}
		
		public function CheckpointLogic(foundations:GameFoundations) 
		{
			super(new CheckpointView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			var width:int = (this.game).mapWidth;
			var sector:int = CheckpointLogic.spawnCount;
			
			if (sector >= width * width) throw new Error();
			
			var sectorX:int = sector % width;
			var sectorY:int = sector / width;
			
			var tlX:int = (sectorX + 1) * Game.SECTOR_WIDTH;
			var tlY:int = (sectorY + 1) * Game.SECTOR_WIDTH;
			
			var cell:CellXY = Metric.getTmpCell(tlX + Math.random() * Game.SECTOR_WIDTH, tlY + Math.random() * Game.SECTOR_WIDTH);
			
			while (this.world.findObjectByCell(cell.x, cell.y))
				cell.setValue(tlX + Math.random() * Game.SECTOR_WIDTH, tlY + Math.random() * Game.SECTOR_WIDTH);
			
			CheckpointLogic.spawnCount++;
			
			return cell;
		}
	}

}