package model.items 
{
	import binding.IBinder;
	import events.GlobalEvent;
	
	/**
	 * This class is an internal Notifier with removal of subscribers supported.
	 * Eh, why not? 
	 */
	internal class ItemNotifier
	{
		private var actors:Vector.<ItemBase>;
		
		public function ItemNotifier(binder:IBinder) 
		{
			binder.eventDispatcher.addEventListener(GlobalEvent.GAME_FRAME,
			                                        this.gameFrame);
			binder.eventDispatcher.addEventListener(GlobalEvent.NEW_GAME,
			                                        this.newGame);
			binder.eventDispatcher.addEventListener(GlobalEvent.QUIT_GAME,
			                                        this.quitGame);
		}
		
		
		private function newGame():void
		{
			this.actors = new Vector.<ItemBase>();
		}
		
		private function gameFrame():void
		{
			var length:int = this.actors.length;
			
			for (var i:int = 0; i < length; i++)
			{
				this.actors[i].gameFrame();
			}
		}
		
		private function quitGame():void 
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