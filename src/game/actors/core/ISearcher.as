package game.actors.core 
{
	import game.metric.CellXY;
	
	public interface ISearcher
	{
		function findObjectByCell(cell:CellXY):ActorBase;
		
		function getCharacterCell(storeIn:CellXY):void;
	}
	
}