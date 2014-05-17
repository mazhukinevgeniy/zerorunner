package controller.observers 
{
	import model.collectibles.Collectible;
	
	public interface ICollectibleObserver 
	{
		function setCollectibleFound(collectible:Collectible):void;
	}
	
}