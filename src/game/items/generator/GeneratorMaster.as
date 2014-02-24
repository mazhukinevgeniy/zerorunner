package game.items.generator 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import utils.updates.update;
	
	public class GeneratorMaster extends MasterBase
	{
		private var elements:GameElements;
		
		private var center:ICoordinated;
		
		public function GeneratorMaster(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.restore);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.numberedFrame);
		}
		
		update function restore(config:GameConfig):void
		{
			var cell:CellXY = new CellXY(0, 0);
			
			for (var i:int = 0; i < Game.MAP_WIDTH / 15; i++)
				for (var j:int = 0; j < Game.MAP_WIDTH / 15; j++)
				{
					cell.setValue(i * 15, j * 15);
					
					new Generator(this, this.elements, cell);
				}
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
		}
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_ACT)
			{
				var x:int = this.center.x % 15;
				var y:int = this.center.y % 15;
				
				var dX:int = x == 1 ? -1 : x == 14 ? 1 : x == 0 ? 0 : 10;
				var dY:int = y == 1 ? -1 : y == 14 ? 1 : y == 0 ? 0 : 10;
				
				if ((dX != 10) && (dY != 10))
				{
					x = normalize(this.center.x + dX);
					y = normalize(this.center.y + dY);
					
					//TODO: show the progress
					if (!this.elements.forceFields.isCellCovered(x, y))
						this.elements.flow.dispatchUpdate(Update.generatorPowered, x, y);
				}
				
			}
		}
		
		override public function tryDestructionOn(puppet:PuppetBase):Boolean 
		{
			return false;
		}
	}

}