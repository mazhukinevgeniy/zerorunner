package model.items 
{
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import model.interfaces.IPuppets;
	import model.status.StatusReporter;
	import utils.normalize;
	
	public class Items implements IPuppets,
	                              INewGameHandler,
								  IQuitGameHandler
	{
		private var items:Array;
		
		
		public function Items(binder:IBinder, status:StatusReporter) 
		{
			binder.notifier.addObserver(this);
			
			new ItemStarter(binder, this, status);
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
			if (this.items[item.x + item.y * Game.MAP_WIDTH])
				throw new Error();
			this.items[item.x + item.y * Game.MAP_WIDTH] = item;
		}
		
		internal function removeItem(item:PuppetBase):void
		{
			this.items[item.x + item.y * Game.MAP_WIDTH] = null;
		}
		//TODO: this should be implemented in the controller probably
		
		
		public function findObjectByCell(x:int, y:int):PuppetBase
		{
			x = normalize(x);
			y = normalize(y);
			
			var item:PuppetBase = this.items[x + y * Game.MAP_WIDTH];
			
			return item;
		}
	}

}