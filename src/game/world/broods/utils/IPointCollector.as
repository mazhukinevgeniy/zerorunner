package game.world.broods.utils 
{
	import game.utils.metric.ICoordinated;
	
	public interface IPointCollector 
	{
		function addPointOfInterest(type:int, point:ICoordinated):void;
		function removePointOfInterest(type:int, point:ICoordinated):void;
		
		function findPointOfInterest(type:int):ICoordinated;
	}
	
}