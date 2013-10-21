package game.items 
{
	import game.items.base.ItemBase;
	
	public interface IActors 
	{
		function findObjectByCell(x:int, y:int):ItemBase;
	}
	
}