package model.interfaces 
{
	import model.collectibles.Collectible;
	
	public interface ICollectibles
	{
		function findCollectible(cellId:int):Collectible;
	}
	
}