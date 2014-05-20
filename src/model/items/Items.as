package model.items 
{
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import model.status.StatusReporter;
	import utils.getCellId;
	
	public class Items implements INewGameHandler,
								  IQuitGameHandler
	{
		private var items:Array;
		
		
		public function Items(binder:IBinder, status:StatusReporter) 
		{
			binder.notifier.addObserver(this);
			
			new ItemStarter(binder, this, status);
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
		
		
		
		internal function addItem(item:PuppetBase):void
		{
			var cellId:int = getCellId(item.x, item.y);
			
			if (this.items[cellId])
				throw new Error();
			this.items[cellId] = item;
		}
		
		internal function removeItem(item:PuppetBase):void
		{
			this.items[getCellId(item.x, item.y)] = null;
		}
		
		internal function getItem(cellId:int):PuppetBase
		{
			return this.items[cellId];
		}
		
		//TODO: temporary and ugly, must find how to destroy items
		public function smashItem(cellId:int):void
		{
			var pup:PuppetBase = this.items[cellId];
			
			pup.tryDestruction();
		}
	}

}