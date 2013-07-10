package game.grinder 
{
	import game.metric.CellXY;
	
	public interface IGrinder 
	{
		function isGrinded(cell:CellXY):Boolean;
		function getFront(y:int):int;
	}
	
}