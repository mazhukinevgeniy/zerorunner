package game.actors.core 
{
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	
	public interface ISearcher
	{
		function findObjectByCell(cell:CellXY):ActorBase;
		
		function getCharacterCell(storeIn:CellXY):void;
		function get character():ICoordinated;
	}
	
}