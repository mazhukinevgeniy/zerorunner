package view.game.renderer 
{
	import data.IStatus;
	import game.GameElements;
	import game.metric.ICoordinated;
	import starling.display.QuadBatch;
	
	internal class SubRendererBase implements IRenderer
	{
		private var status:IStatus;
		
		protected var layer:QuadBatch;
		
		public function SubRendererBase(elements:GameElements, layer:QuadBatch) 
		{
			this.status = elements.status;
			
			this.layer = layer;
			
			super();
		}
		
		public function redraw():void
		{
			var center:ICoordinated = this.status.getLocationOfHero();
			
			var x:int = center.x;
			var y:int = center.y;
			
			const RANGE:int = Math.abs(this.range);
			
			for (var i:int = -RANGE; i < RANGE + 1; i++)
				for (var j:int = -RANGE; j < RANGE + 1; j++)
				{
					/* Render the square row by row */
					this.renderCell(x + j, y + i);
				}
		}
		
		
		protected function renderCell(x:int, y:int):void
		{
			throw new Error("must implement");
		}
		
		protected function get range():int
		{
			throw new Error("must implement");
		}
		
	}

}