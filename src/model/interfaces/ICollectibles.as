package model.interfaces 
{
	import model.collectibles.Collectible;
	
	public interface ICollectibles
	{
		function findCollectible(x:int, y:int):Collectible;
	}
	
}