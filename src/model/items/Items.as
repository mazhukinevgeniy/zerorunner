package model.items 
{
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import model.items.concrete.ItemSpawner;
	import model.status.StatusReporter;
	
	public class Items implements INewGameHandler,
								  IQuitGameHandler
	{
		private var items:Array;
		
		internal var notifier:ItemNotifier;
		
		public function Items(binder:IBinder, status:StatusReporter) 
		{
			binder.notifier.addObserver(this);
			
			this.notifier = new ItemNotifier(binder);
			
			new ItemSpawner(binder, this, status);
			new ItemSnapshotter(this, binder);
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
		
		//TODO: temporary and ugly, must find how to destroy items
		public function smashItem(cellId:int):void
		{
			var item:ItemBase = this.items[cellId];
			
			item.tryDestruction();
		}
	}

}