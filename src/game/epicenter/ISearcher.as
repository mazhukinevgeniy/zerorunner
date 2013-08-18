package game.epicenter 
{
	import game.broods.ItemLogicBase;
	import game.utils.metric.ICoordinated;
	
	public interface ISearcher 
	{
		function findObjectByCell(x:int, y:int):ItemLogicBase;
		function getCenter():ICoordinated;
		
		function getSceneCell(x:int, y:int):int;
	}
	
}