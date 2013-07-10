package chaotic.actors.storage 
{
	import chaotic.metric.CellXY;
	
	public interface ISearcher
	{
		function findObjectByCell(cell:CellXY):Puppet;
		function findObjectsInSquare(tlX:int, tlY:int, width:int):Vector.<Puppet>;
		
		function getCharacterCell():CellXY;
	}
	
}