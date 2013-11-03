package game.items 
{
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.Items;
	import starling.display.DisplayObject;
	
	use namespace items_internal;
	
	public class PuppetBase implements ICoordinated
	{
		private var _master:MasterBase;
		
		private var _x:int, _y:int;
		
		private var occupation:int;
		
		private var ticksOccupated:int;
		private var ticksUntilOccupationEnds:int;
		
		private var previousPosition:CellXY;
		
		private var items:Items;
		
		/* Used to avoid creation. */
		private var dcHelper:DCellXY;
		
		public function PuppetBase(master:MasterBase, elements:GameElements, cell:CellXY = null) 
		{
			this._master = master;
			this.items = elements.items;
			
			this.dcHelper = new DCellXY(0, 0);
			this.previousPosition = new CellXY(0, 0);
			
			if (cell == null)
			{
				const width:int = elements.database.config.width;
				
				cell = new CellXY(Game.BORDER_WIDTH + Math.random() * width, 
								  Game.BORDER_WIDTH + Math.random() * width);
				
				while (this.items.findObjectByCell(cell.x, cell.y))
					cell.setValue(Game.BORDER_WIDTH + Math.random() * width, 
								  Game.BORDER_WIDTH + Math.random() * width);
			}
			
			this._x = cell.x;
			this._y = cell.y;
			
			this.items.addItem(this);
			
			this.onSpawned();
		}
		
		final internal function forceDestruction():void
		{
			this.occupation = Game.DYING;
		}
		
		final internal function tickPassed():void
		{
			if (this.occupation == Game.FREE)
			{
				
			}
			else if (this.occupation == Game.MOVING)
			{
				this.ticksOccupated++;
				if (this.ticksOccupated == this.ticksUntilOccupationEnds)
					this.occupation = Game.FREE;
			}			
			else if (this.occupation == Game.DYING)
			{
				this.items.removeItem(this);
				
				this.onDied();
			}
		}
		
		final internal function act():void
		{
			this._master.actOn(this);
		}
		
		
		final items_internal function get master():MasterBase { return this._master; }
		final items_internal function get free():Boolean { return this.occupation == Game.FREE; }
		
		
		final items_internal function forceShocking(target:ICoordinated = null):void
		{
			
		}
		
		
		
		/** Position and movements */
		
		final public function get x():int { return this._x; }
		final public function get y():int { return this._y; }
		
		final items_internal function forceMoveTo(target:ICoordinated):void
		{
			this.dcHelper.setValue(target.x - this._x, target.y - this._y);
			
			this.forceMoveBy(this.dcHelper);
		}
		
		final items_internal function forceMoveBy(change:DCellXY):void
		{
			this.items.removeItem(this);
			this.previousPosition.setValue(this._x, this._y);
			
			this._x += change.x;
			this._y += change.y;
			
			this.items.addItem(this);
			
			
			this.occupation = Game.MOVING;
			this.ticksUntilOccupationEnds = this.movespeed;
			this.ticksOccupated = 0;
			
			this.onMoved(change);
		}
		
		final items_internal function forceJumpBy(change:DCellXY, length:int):void
		{
			this.dcHelper.setValue(change.x * length, change.y * length);
			
			this.forceMoveBy(this.dcHelper);
			
			//this.item.cooldown = this.MOVE_SPEED * 2 * multiplier;
			//TODO: handle onMoved conflict (can't apply custom delay)
			//TODO: think if jumps must be slower than walking
		}
		
		/** END OF Position and movements */
		
		
		/** Things to override */
		
		protected function get movespeed():int { return 1; }
		
		protected function onMoved(change:DCellXY):void { }
		protected function onSpawned():void { }
		protected function onDied():void { }
	}

}