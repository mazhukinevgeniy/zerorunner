package view.game.renderer 
{
	import binding.IBinder;
	import model.interfaces.IStatus;
	import model.metric.ICoordinated;
	import starling.display.QuadBatch;
	
	internal class SubRendererBase implements IRenderer
	{
		private var status:IStatus;
		
		protected var layer:QuadBatch;
		
		private var _dx:int;
		private var dx:int;
		private var _dy:int;
		private var dy:int;
		
		public function SubRendererBase(binder:IBinder, layer:QuadBatch, changes:Changes) 
		{
			this.status = binder.gameStatus;
			
			this.layer = layer;
			
			
			this._dx = changes._dx;
			this.dx = changes.dx;
			this._dy = changes._dy;
			this.dy = changes.dy;
		}
		
		public function redraw():void
		{
			var center:ICoordinated = this.status.getLocationOfHero();
			
			var x:int = center.x;
			var y:int = center.y;
			
			for (var i:int = this._dx; i < this.dx + 1; i++)
				for (var j:int = this._dy; j < this.dy + 1; j++)
				{
					/* Render row by row */
					this.renderCell(x + j, y + i);
				}
		}
		
		
		protected function renderCell(x:int, y:int):void
		{
			throw new Error("must implement");
		}
		
	}

}