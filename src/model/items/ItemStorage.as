package model.items 
{
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	
	internal class ItemStorage implements INewGameHandler,
								          IQuitGameHandler
	{
		private var items:Array;
		
		public function ItemStorage(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
		}
		
		public function newGame():void
		{
			this.items = new Array();
		}
		
		public function quitGame():void
		{
			this.items = null;
		}
		
		
		
		internal function addItem(item:ItemBase, cellId:int):void
		{
			if (this.items[cellId])
				throw new Error();
			this.items[cellId] = item;
		}
		
		internal function removeItem(cellId:int):void
		{
			this.items[cellId] = null;
		}
		
		internal function getItem(cellId:int):ItemBase
		{
			return this.items[cellId];
		}
	}

}