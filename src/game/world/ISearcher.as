package game.world 
{
	import game.actors.types.ActorLogicBase;
	import game.metric.ICoordinated;
	
	public interface ISearcher 
	{
		function findObjectByCell(x:int, y:int):ActorLogicBase;
		function getCenter():ICoordinated;
		
		function getSceneCell(x:int, y:int):int;
	}
	
}