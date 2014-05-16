package view.game.renderer 
{
	import binding.IBinder;
	import model.interfaces.IStatus;
	import model.metric.ICoordinated;
	import starling.display.QuadBatch;
	
	internal class SubRendererBase extends QuadBatch implements IRenderer
	{
		private var status:IStatus;
		
		private var _dx:int;
		private var dx:int;
		private var _dy:int;
		private var dy:int;
		
		public function SubRendererBase(binder:IBinder, changes:Changes) 
		{
			this.status = binder.gameStatus;
			
			this._dx = changes._dx;
			this.dx = changes.dx;
			this._dy = changes._dy;
			this.dy = changes.dy;
			
			super();
		}
		
		public function redraw():void
		{
			this.reset();
			
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