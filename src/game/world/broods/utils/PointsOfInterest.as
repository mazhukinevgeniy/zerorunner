package game.world.broods.utils 
{
	import game.utils.metric.CellXY;
	import game.utils.metric.ICoordinated;
	
	public class PointsOfInterest implements IPointCollector
	{
		private var types:Array;
		
		public function PointsOfInterest() 
		{
			
		}
		
		public function addPointOfInterest(type:int, point:ICoordinated):void
		{
			if (this.types[type] == null)
				this.types[type] = new Vector.<ICoordinated>();
			
			this.types[type].push(point);
		}
		
		public function findPointOfInterest(type:int):ICoordinated
		{
			var vector:Vector.<ICoordinated> = this.types[type];
			if (!vector) 
				return null;
			
			var length:int = vector.length;
			return vector[int(Math.random() * length)];
		}
		
		/**
		 * Interfaceless
		 */
		
		public function clearPointsOfInterest():void
		{
			this.types = new Array();
		}
	}

}