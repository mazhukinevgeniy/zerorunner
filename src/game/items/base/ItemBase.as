package game.items.base 
{
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.GameElements;
	import game.items.Items;
	import game.items.items_internal;
	import starling.display.DisplayObject;
	
	use namespace items_internal;
	
	public class ItemBase extends CellXY
	{
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
			
			super(cell.x, cell.y);
			
			this.items.addItem(this);
		}
		
		
		final override public function setValue(x:int, y:int):void { throw new Error(); }
		items_internal function setValue(x:int, y:int):void { super.setValue(x, y); }
		
		
		
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
	}

}