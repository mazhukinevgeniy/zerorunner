package game.items.base.cores 
{
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.items.base.CoreBase;
	import game.items.base.ItemBase;
	import game.items.items_internal;
	
	public class ExistenceCore extends CoreBase implements ICoordinated
	{
		
		
		private var _x:int;
		private var _y:int;
		
		public function ExistenceCore(elements:GameElements, cell:ICoordinated) 
		{
			if (cell == null)
			{
				const width:int = elements.database.config.width;
				
				do
					cell = Metric.getTmpCell(Game.BORDER_WIDTH + Math.random() * width, 
											 Game.BORDER_WIDTH + Math.random() * width);
				while (elements.actors.findObjectByCell(cell.x, cell.y));
			}
			
			this._x = cell.x;
			this._y = cell.y;
			
			this.actorTracker.addActor(this);
			
			this.view.standOn(cell);
		}
		
		items_internal function move(change:DCellXY, delay:int):void
		{
			var blocker:ItemBase = this.actors.findObjectByCell(this.x + change.x, this.y + change.y);
			
			if (!blocker)
			{
				this.item.cooldown = delay;
				
				this._x += change.x;
				this._y += change.y;
				
				this.actorTracker.moveActor(this, change);
				
				this.item.view.move(this, change, delay + 1);
			}
			else
				this.item.collider.collideWith(blocker);
		}
		
		items_internal function applyDestruction():void
		{
			this.actorTracker.removeActor(this);
			
			this.view.disappear();
		}
		
		final public function get x():int {	return this._x;	}
		final public function get y():int {	return this._y;	}
	}

}