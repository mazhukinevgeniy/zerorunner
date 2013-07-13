package game.actors.storage 
{
	import game.metric.CellXY;
	
	public interface ISearcher
	{
		function findObjectByCell(cell:CellXY):Puppet;
		
		function getCharacterCell(storeIn:CellXY):void;
	}
	
}