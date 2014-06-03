package view.game.renderer.effects 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import model.collectibles.Collectible;
	import starling.events.Event;
	
	internal class CollectionTracker extends TrackerBase
	{
		
		public function CollectionTracker(binder:IBinder) 
		{
			super(binder);
			
			binder.eventDispatcher.addEventListener(GlobalEvent.COLLECTIBLE_FOUND,
			                                        this.collectibleFound);
		}
		
		private function collectibleFound(event:Event, collectible:Collectible):void
		{
			var duration:int = EffectRenderer.COLLECTION_LENGTH * 
			                   EffectRenderer.COLLECTION_SPEED_FACTOR;
			
			this.addEffect(duration, collectible);
		}
	}

}