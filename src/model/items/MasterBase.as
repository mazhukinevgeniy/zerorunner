package model.items 
{
	import binding.IBinder;
	import controller.observers.game.IQuitGameHandler;
	import model.metric.DCellXY;
	
	public class MasterBase implements IQuitGameHandler
	{
		protected var _binder:IBinder;
		
		private var _items:Items;
		
		public function MasterBase(binder:IBinder, items:Items) 
		{
			this._binder = binder;
			this._items = items;
			
			binder.notifier.addObserver(this);
		}
		
		public function quitGame():void { this.onGameFinished(); }
		
		
		internal function actOn(puppet:PuppetBase):void
		{
			if (puppet.occupation != Game.OCCUPATION_DYING)
				this.act(puppet);
		}
		
		
		protected function act(puppet:PuppetBase):void { }
		protected function onGameFinished():void { }
		
		
		public function spawnPuppet(x:int, y:int):void
		{
			throw new Error("must implement");
		}
		
		
		final protected function movePuppet(puppet:PuppetBase, change:DCellXY):void
		{
			puppet.startMovingBy(change);
		}
		
		/* For the puppet */
		internal function get binder():IBinder { return this._binder; }
		internal function get items():Items { return this._items; }
	}

}