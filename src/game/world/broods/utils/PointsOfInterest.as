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
			if (this.types[type].indexOf(point) == -1)
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
		
		public function removePointOfInterest(type:int, point:ICoordinated):void
		{
			var vector:Vector.<ICoordinated> = this.types[type];
			if (!vector) 
				return;
			
			var position:int = vector.indexOf(point);
			if (position != -1)
				vector.splice(position, 1);
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