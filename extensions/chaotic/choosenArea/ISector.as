package chaotic.choosenArea 
{
	import chaotic.metric.CellXY;
	
	public interface ISector 
	{
		function get topLeftCell():CellXY;
		
		function getCode():Vector.<int>;
	}
	
}