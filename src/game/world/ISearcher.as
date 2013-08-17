package game.world 
{
	import game.broods.ItemLogicBase;
	import game.metric.ICoordinated;
	
	public interface ISearcher 
	{
		function findObjectByCell(x:int, y:int):ItemLogicBase;
		function getCenter():ICoordinated;
		
		function getSceneCell(x:int, y:int):int;
	}
	
}