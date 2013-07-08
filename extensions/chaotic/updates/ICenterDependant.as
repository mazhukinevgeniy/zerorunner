package chaotic.updates 
{
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	
	public interface ICenterDependant 
	{
		function moveCenter(change:DCellXY, ticksToGo:int = 0):void;
		function setCenter(cell:CellXY):void;
	}
	
}