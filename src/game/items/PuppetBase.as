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
		
		internal var _x:int, _y:int;
		private var occupation:int;
		
		
		protected var items:Items;
		
		/* Used to avoid creation. */
		private var dcHelper:DCellXY;
		
		public function PuppetBase(master:MasterBase, elements:GameElements, cell:CellXY = null) 
		{
			this._master = master;
			this.items = elements.items;
			
			this.dcHelper = new DCellXY(0, 0);
			
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
		}
		
		
		
		final public function get x():int { return this._x; }
		final public function get y():int { return this._y; }
		
		final items_internal function get master():MasterBase { return this._master; }
		final items_internal function get free():Boolean { return this.occupation == Game.FREE; }
		
		
		final items_internal function forceShocking(target:ICoordinated = null):void
		{
			//if behaviour is charge based, this dependancy is to be adressed by master
			//TODO: read above
		}
		
		final items_internal function forceMoveTo(target:ICoordinated):void
		{
			this.dcHelper.setValue(target.x - this._x, target.y - this._y);
			
			this.forceMoveBy(this.dcHelper);
		}
		
		final items_internal function forceMoveBy(change:DCellXY):void
		{
			this.items.removeItem(this);
			
			this._x += change.x;
			this._y += change.y;
			
			this.items.addItem(this);
			
			
			this.onMoved(change);
		}
		
		final items_internal function forceJumpBy(change:DCellXY, length:int):void
		{
			//TODO: preferably convert to forceMoveBy call with sweets
		}
		
		/**
		 * Override if need special execution
		 */
		protected function onMoved(change:DCellXY):void
		{
			
		}
	}

}