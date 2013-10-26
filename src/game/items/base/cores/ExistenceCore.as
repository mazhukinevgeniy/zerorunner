package game.items.base.cores 
{
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.items.base.CoreBase;
	import game.items.base.ItemBase;
	import game.items.Items;
	import game.items.items_internal;
	
	use namespace items_internal;
	
	public class ExistenceCore extends CoreBase implements ICoordinated
	{
		protected var items:Items;
		
		private var _x:int;
		private var _y:int;
		
		private var _delay:int;
		
		public function ExistenceCore(item:ItemBase, elements:GameElements, cell:ICoordinated, delay:int = 2) 
		{
			super(item);
			
			this.items = elements.items;
			
			if (cell == null)
			{
				const width:int = elements.database.config.width;
				
				do
					cell = Metric.getTmpCell(Game.BORDER_WIDTH + Math.random() * width, 
											 Game.BORDER_WIDTH + Math.random() * width);
				while (this.items.findObjectByCell(cell.x, cell.y));
			}
			
			this._x = cell.x;
			this._y = cell.y;
			
			this.items.addItem(this);
			
			this._delay = delay;
		}
		
		items_internal function move(change:DCellXY):void
		{
			var delay:int = this._delay;
			
			var blocker:ExistenceCore = this.items.findObjectByCell(this.x + change.x, this.y + change.y);
			
			if (!blocker)
			{
				this.item.cooldown = delay;
				
				this.items.removeItem(this);
				
				this._x += change.x;
				this._y += change.y;
				
				this.items.addItem(this);
			}
			else
				this.item.collider.collideWith(blocker.item);
		}
		
		items_internal function moveTo(goal:ICoordinated):void
		{
			var delay:int = this._delay;
			var blocker:ExistenceCore = this.items.findObjectByCell(goal.x, goal.y);
			
			if (!blocker)
			{
				this.item.cooldown = delay;
				
				this.items.removeItem(this);
				
				this._x = goal.x;
				this._y = goal.y;
				
				this.items.addItem(this);
			}
			else
				this.item.collider.collideWith(blocker.item);
		}
		
		items_internal function applyDestruction():void
		{
			this.items.removeItem(this);
		}
		
		final public function get x():int {	return this._x;	}
		final public function get y():int {	return this._y;	}
	}

}