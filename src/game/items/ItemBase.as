package game.items 
{
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.Items;
	import starling.display.DisplayObject;
	
	
	public class ItemBase implements ICoordinated
	{
		internal var _x:int, _y:int;
		
		protected var items:Items;
		//TODO: check if need
		
		
		public function ItemBase(elements:GameElements, cell:CellXY = null) 
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
		
		internal function applyDestruction():void
		{
			this.items.removeItem(this);
		}//TODO: is it here?
		
		
		
		public function act():void
		{
			
		}
		
		
		
		final item_exposure function tryMove():Boolean
		{
			return false;
		}
		
		final item_exposure function tryShock():Boolean
		{
			return false;
		}
		
		
		public function get x():int { return this._x; }
		public function get y():int { return this._y; }
	}

}