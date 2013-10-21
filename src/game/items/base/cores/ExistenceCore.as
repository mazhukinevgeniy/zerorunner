package game.items.base.cores 
{
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.Metric;
	import game.items.base.CoreBase;
	
	public class ExistenceCore extends CoreBase
	{
		private var _x:int;
		private var _y:int;
		
		public function ExistenceCore() 
		{
			
		}
		
		override public function reset():void 
		{
			var cell:CellXY = this.getSpawningCell();
			this._x = cell.x;
			this._y = cell.y;
			
			this.actorTracker.addActor(this);
			
			this.view.standOn(cell);
		}
		
		protected function getSpawningCell():CellXY
		{
			const width:int = this.config.width;
			
			var cell:CellXY = Metric.getTmpCell(Game.BORDER_WIDTH + Math.random() * width, 
												Game.BORDER_WIDTH + Math.random() * width);
			
			for (; this.actors.findObjectByCell(cell.x, cell.y); )
				cell.setValue(Game.BORDER_WIDTH + Math.random() * width, Game.BORDER_WIDTH + Math.random() * width);
			
			return cell;
		}
		
		protected function move(change:DCellXY, delay:int):void
		{
			if (!this.actors.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				this._x += change.x;
				this._y += change.y;
				
				this.actorTracker.moveActor(this, change);
				
				this.view.move(this, change, delay + 1);
			}
			else
				throw new Error();
		}
		
		final public function get x():int {	return this._x;	}
		final public function get y():int {	return this._y;	}
	}

}