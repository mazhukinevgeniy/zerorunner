package chaotic.actors.storage 
{
	import chaotic.metric.CellXY;
	
	public interface ISearcher
	{
		function findObjectByCell(cell:CellXY):Puppet;
		function getCharacterCell():CellXY;
	}
	
}