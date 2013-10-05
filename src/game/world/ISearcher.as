package game.world 
{
	import game.world.items.utils.ItemLogicBase;
	
	public interface ISearcher 
	{
		function findObjectByCell(x:int, y:int):ItemLogicBase;
		
		function getSceneCell(x:int, y:int):int;
	}
	
}