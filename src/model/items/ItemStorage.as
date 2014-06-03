package model.items 
{
	import binding.IBinder;
	import events.GlobalEvent;
	
	internal class ItemStorage
	{
		private var items:Array;
		
		public function ItemStorage(binder:IBinder) 
		{
			binder.eventDispatcher.addEventListener(GlobalEvent.NEW_GAME,
			                                        this.newGame);
			binder.eventDispatcher.addEventListener(GlobalEvent.QUIT_GAME,
			                                        this.quitGame);
		}
		
		private function newGame():void
		{
			this.items = new Array();
		}
		
		private function quitGame():void
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