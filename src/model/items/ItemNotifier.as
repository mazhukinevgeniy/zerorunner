package model.items 
{
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	
	/**
	 * This class is an internal Notifier with removal of subscribers supported.
	 * Eh, why not? 
	 */
	internal class ItemNotifier implements INewGameHandler, IGameFrameHandler, IQuitGameHandler
	{
		private var actors:Vector.<ItemBase>;
		
		public function ItemNotifier(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
		}
		
		
		public function newGame():void
		{
			this.actors = new Vector.<ItemBase>();
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
		
		/**
		 * Use this method if you want some puppet to act
		 * @param	actor
		 */
		internal function addActor(actor:ItemBase):void
		{
			this.actors.push(actor);
		}
		
		internal function removeActor(actor:ItemBase):void
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
	}

}