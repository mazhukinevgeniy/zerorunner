package game.items 
{
	import game.items.items_internal;
	
	internal class CoreBase 
	{
		private var _item:ItemBase;
		
		public function CoreBase(item:ItemBase) 
		{
			this._item = item;
		}
		
		items_internal function get item():ItemBase
		{
			return this._item;
		}
	}

}