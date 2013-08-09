package game.actors 
{
	import game.actors.types.ActorLogicBase;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	
	public interface ISearcher
	{
		function findObjectByCell(x:int, y:int):ActorLogicBase;
		
		function get character():ICoordinated;
	}
	
}