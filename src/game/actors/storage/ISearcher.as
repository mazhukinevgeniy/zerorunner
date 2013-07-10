package game.actors.storage 
{
	import game.metric.CellXY;
	
	public interface ISearcher
	{
		function findObjectByCell(cell:CellXY):Puppet;
		function findObjectsInSquare(tlX:int, tlY:int, width:int):Vector.<Puppet>;
		
		function getCharacterCell():CellXY;
	}
	
}