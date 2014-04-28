package game.ui.renderer 
{
	import game.GameElements;
	import game.metric.ICoordinated;
	import starling.display.QuadBatch;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class SubRendererBase implements IRenderer
	{
		private var center:ICoordinated;
		
		protected var layer:QuadBatch;
		
		public function SubRendererBase(elements:GameElements, layer:QuadBatch) 
		{
			var flow:IUpdateDispatcher = elements.flow;
			
			this.layer = layer;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.setCenter);
			flow.addUpdateListener(Update.quitGame);
			
			super();
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
			
			this.handleGameStarted();
		}
		
		public function redraw(frame:int):void
		{
			if (this.checkIfShouldRender(frame))
			{
				var x:int = this.center.x;
				var y:int = this.center.y;
				
				const RANGE:int = Math.abs(this.range);
				
				for (var i:int = -RANGE; i < RANGE + 1; i++)
					for (var j:int = -RANGE; j < RANGE + 1; j++)
					{
						/* Render the square row by row */
						this.renderCell(x + j, y + i, frame);
					}
			}
		}
		
		update function quitGame():void
		{
			this.center = null;
		}
		
		
		protected function renderCell(x:int, y:int, frame:int):void
		{
			throw new Error("must implement");
		}
		
		protected function get range():int
		{
			throw new Error("must implement");
		}
		
		
		protected function checkIfShouldRender(frame:int):Boolean
		{
			return true;
		}
		
		protected function handleGameStarted():void
		{
			
		}
	}

}