package game.items.base.cores 
{
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.items.base.CoreBase;
	
	public class ExistenceCore extends CoreBase implements ICoordinated
	{
		
		
		private var _x:int;
		private var _y:int;
		
		public function ExistenceCore(cell:ICoordinated) 
		{
			this._x = cell.x;
			this._y = cell.y;
			
			this.actorTracker.addActor(this);
			
			this.view.standOn(cell);
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
		
		public function applyDestruction():void
		{
			this.actorTracker.removeActor(this);
			
			this.view.disappear();
		}
		
		final public function get x():int {	return this._x;	}
		final public function get y():int {	return this._y;	}
	}

}