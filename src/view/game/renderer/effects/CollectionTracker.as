package view.game.renderer.effects 
{
	import binding.IBinder;
	import controller.observers.ICollectibleObserver;
	import model.collectibles.Collectible;
	
	internal class CollectionTracker extends TrackerBase implements ICollectibleObserver
	{
		
		public function CollectionTracker(binder:IBinder) 
		{
			super(binder);
		}
		
		public function setCollectibleFound(collectible:Collectible):void
		{
			var duration:int = EffectRenderer.COLLECTION_LENGTH * 
			                   EffectRenderer.COLLECTION_SPEED_FACTOR;
			
			this.addEffect(duration, collectible);
		}
	}

}