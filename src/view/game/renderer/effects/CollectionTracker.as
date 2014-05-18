package view.game.renderer.effects 
{
	import binding.IBinder;
	import controller.observers.ICollectibleObserver;
	import model.collectibles.Collectible;
	import view.game.renderer.structs.Effect;
	
	internal class CollectionTracker extends TrackerBase implements ICollectibleObserver
	{
		
		public function CollectionTracker(binder:IBinder) 
		{
			super(binder);
		}
		
		public function setCollectibleFound(collectible:Collectible):void
		{
			var effect:Effect = new Effect();
			
			effect.duration = EffectRenderer.COLLECTION_LENGTH * 
			                  EffectRenderer.COLLECTION_SPEED_FACTOR;
			
			this.addEffect(effect, collectible);
		}
	}

}