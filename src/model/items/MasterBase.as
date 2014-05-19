package model.items 
{
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import model.interfaces.IStatus;
	import model.metric.DCellXY;
	
	public class MasterBase implements INewGameHandler, IGameFrameHandler, IQuitGameHandler
	{
		private var actors:Vector.<PuppetBase>;
		
		protected var _binder:IBinder;
		
		private var _items:Items;
		private var _status:IStatus;
		
		public function MasterBase(binder:IBinder, items:Items) 
		{
			this._binder = binder;
			this._items = items;
			this._status = binder.gameStatus;
			
			binder.notifier.addObserver(this);
		}
		
		
		public function newGame():void
		{
			this.actors = new Vector.<PuppetBase>();
		}
		
		public function gameFrame(frame:int):void
		{
			var length:int = this.actors.length;
			
			for (var i:int = 0; i < length; i++)
			{
				this.actors[i].gameFrame(frame);
			}
		}
		
		public function quitGame():void 
		{ 
			this.actors = null; 
		}
		
		
		public function spawnPuppet(x:int, y:int):void
		{
			throw new Error("must implement");
		}
		
		/**
		 * Use this method if you want some puppet to act
		 * @param	actor
		 */
		protected function addActor(actor:PuppetBase):void
		{
			this.actors.push(actor);
		}
		
		protected function removeActor(actor:PuppetBase):void
		{
			var pos:int = this.actors.indexOf(actor);
			var len:int = this.actors.length;
			
			if (pos == len)
			{
				this.actors.pop();
			}
			else if (pos > -1)
			{
				this.actors[pos] = this.actors[len];
				this.actors.pop();
			}
		}
		
		/* For the puppet */
		internal function get binder():IBinder { return this._binder; }
		internal function get items():Items { return this._items; }
		internal function get status():IStatus { return this._status; }
	}

}