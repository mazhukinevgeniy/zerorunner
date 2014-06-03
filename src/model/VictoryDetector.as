package model 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import model.collectibles.Collectible;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	internal class VictoryDetector
	{
		private var dispatcher:EventDispatcher;
		
		public function VictoryDetector(binder:IBinder) 
		{
			this.dispatcher = binder.eventDispatcher;
			
			this.dispatcher.addEventListener(GlobalEvent.COLLECTIBLE_FOUND,
			                                 this.collectibleFound);
		}
		
		public function collectibleFound(event:Event, collectible:Collectible):void
		{
			if (collectible.type == Game.COLLECTIBLE_GOAL)
			{
				this.dispatcher.dispatchEventWith(GlobalEvent.GAME_STOPPED,
				                                  false,
												  Game.ENDING_WON);
			}
		}
	}

}