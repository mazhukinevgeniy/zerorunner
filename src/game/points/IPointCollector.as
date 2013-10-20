package game.points 
{
	import game.core.metric.ICoordinated;
	
	public interface IPointCollector 
	{
		function addPointOfInterest(type:int, point:ICoordinated):void;
		function removePointOfInterest(type:int, point:ICoordinated):void;
		
		function findPointOfInterest(type:int):ICoordinated;
		function getPointsOfInterest(type:int):Vector.<ICoordinated>;
	}
	
}