package game.renderer 
{
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.base.ItemBase;
	import game.points.IPointCollector;
	import starling.display.QuadBatch;
	import utils.updates.update;
	
	internal class ItemRenderer extends QuadBatch
	{
		private var points:IPointCollector;
		
		public function ItemRenderer(elements:GameElements) 
		{
			super();
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			this.points = elements.pointsOfInterest;
		}
		
		update function numberedFrame(key:int):void
		{
			this.redraw();
		}
		
		update function quitGame():void
		{
			this.reset();
		}
		
		private function redraw():void
		{
			this.reset();
			
			var center:ICoordinated = this.points.findPointOfInterest(Game.CHARACTER);
			
			//TODO: find and render everyone
		}
	}

}