package game.world.broods.utils 
{
	import game.utils.metric.CellXY;
	import game.utils.metric.ICoordinated;
	
	public class PointsOfInterest implements IPointCollector
	{
		
		public function PointsOfInterest() 
		{
			
		}
		
		public function addPointOfInterest(type:int, point:ICoordinated):void
		{
			
		}
		
		public function removePointOfInterest(type:int, point:ICoordinated):void
		{
			
		}
		
		public function findPointOfInterest(type:int):ICoordinated
		{
			return new CellXY(100, 100); //TODO: implement
		}
		
		/**
		 * Interfaceless
		 */
		
		public function clearPointsOfInterest():void
		{
			
		}
		
		//TODO: implement
	}

}