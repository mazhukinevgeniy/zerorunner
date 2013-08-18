package game.world 
{
	import game.utils.metric.ICoordinated;
	import game.world.broods.ItemLogicBase;
	
	public interface ISearcher 
	{
		function findObjectByCell(x:int, y:int):ItemLogicBase;
		function getCenter():ICoordinated;
		
		function getSceneCell(x:int, y:int):int;
	}
	
}