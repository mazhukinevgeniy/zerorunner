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
		//TODO: generators are not active, so subscribe to numbered frames and act act act
		
		private var elements:GameElements;
		
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
			
		}
		
		update function numberedFrame(frame:int):void
		{
			
		}
		
		override public function tryDestructionOn(puppet:PuppetBase):Boolean 
		{
			return false;
		}
	}

}