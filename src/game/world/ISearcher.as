package game.world 
{
	import game.items.ActorLogicBase;
	import game.metric.ICoordinated;
	
	public interface ISearcher 
	{
		function findObjectByCell(x:int, y:int):ActorLogicBase;
		function getCenter():ICoordinated;
		
		function getSceneCell(x:int, y:int):int;
	}
	
}