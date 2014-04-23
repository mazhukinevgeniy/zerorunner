package game.items.generator 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.items._utils.CheckpointMasterBase;
	import game.items.PuppetBase;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import utils.updates.update;
	
	public class GeneratorMaster extends CheckpointMasterBase
	{
		private var center:ICoordinated;
		
		public function GeneratorMaster(elements:GameElements) 
		{
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.setCenter);
			
			super(elements);
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			//TODO: rethink the design of them generators, then add them to the map and implement that method
			
			/*
			
			var cell:CellXY = new CellXY(0, 0);
			
			for (var i:int = 0; i < Game.MAP_WIDTH / 15; i++)
				for (var j:int = 0; j < Game.MAP_WIDTH / 15; j++)
				{
					cell.setValue(i * 15, j * 15);
					
					if (this.elements.scene.getSceneCell(cell.x, cell.y) == Game.SCENE_GROUND)
						new Generator(this, this.elements, cell);
				}
			
			 */
			
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
		}
		
		override protected function getReachedCheckpoint():ICoordinated 
		{/*
			var x:int = this.center.x % 15;
			var y:int = this.center.y % 15;
			
			var dX:int = x == 1 ? -1 : x == 14 ? 1 : x == 0 ? 0 : 10;
			var dY:int = y == 1 ? -1 : y == 14 ? 1 : y == 0 ? 0 : 10;
			
			if ((dX != 10) && (dY != 10))
			{
				x = normalize(this.center.x + dX);
				y = normalize(this.center.y + dY);
				
				this.tmpCell.setValue(x, y);
				return this.tmpCell;
				
				//TODO: show the progress
			}
			else
			{*/
				return CheckpointMasterBase.ILLEGAL_CELL;
			/*}*/
		}
		
		override protected function activateCheckpoint(place:ICoordinated):void 
		{
			var x:int = place.x;
			var y:int = place.y;
			
			var item:PuppetBase = this.elements.items.findAnyObjectByCell(x, y);
			
			if (item && item is Generator)
				if (!this.elements.forceFields.isCellCovered(x, y))
					this.elements.flow.dispatchUpdate(Update.generatorPowered, x, y);
		}
	}

}