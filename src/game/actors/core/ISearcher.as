package game.actors.core 
{
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	
	public interface ISearcher
	{
		function findObjectByCell(x:int, y:int):ActorBase;
		
		function getCharacterCell(storeIn:CellXY):void;
		function get character():ICoordinated;
	}
	
}