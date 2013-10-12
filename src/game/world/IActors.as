package game.world 
{
	import game.world.items.utils.ItemLogicBase;
	
	public interface IActors 
	{
		function findObjectByCell(x:int, y:int):ItemLogicBase;
	}
	
}