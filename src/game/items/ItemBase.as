package game.items 
{
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.Items;
	import game.items.items_internal;
	import starling.display.DisplayObject;
	
	use namespace items_internal;
	
	public class ItemBase implements ICoordinated
	{
		internal var _x:int, _y:int;
		
		protected var _contraption:ContraptionCore;
		protected var _collider:CollisionCore;
		protected var _activity:ActivityCore;
		
		protected var items:Items;
		
		
		private var _occupation:OccupationCore;
		
		public function ItemBase(elements:GameElements, cell:CellXY) 
		{
			this.items = elements.items;
			
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
		
		
		protected function onMoved():void
		{
			
		}//TODO: how must it be implemented?
		
		items_internal function applyDestruction():void
		{
			this.items.removeItem(this);
		}
		
		
		
		
		final items_internal function get contraption():ContraptionCore { return this._contraption; }
		final items_internal function get collider():CollisionCore { return this._collider; }
		final items_internal function get activity():ActivityCore { return this._activity; }
		
		
		
		public function get x():int { return this._x; }
		public function get y():int { return this._y; }
	}

}