package chaotic.updates 
{
	import chaotic.choosenArea.ISector;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	
	public interface IDependOnChoosenArea 
	{
		function newTopLeftCell(cell:CellXY):void;
		function movedTopLeftCell(cChange:DCellXY):void;
		
		function addedScenePiece(sector:ISector):void;
	}
	
}