package chaotic.grinder 
{
	import chaotic.metric.CellXY;
	
	public interface IGrinder 
	{
		function isGrinded(cell:CellXY):Boolean;
		function getFront(y:int):int;
	}
	
}