package game.items 
{
	import game.items.base.ItemLogicBase;
	
	public interface IActors 
	{
		function findObjectByCell(x:int, y:int):ItemLogicBase;
	}
	
}