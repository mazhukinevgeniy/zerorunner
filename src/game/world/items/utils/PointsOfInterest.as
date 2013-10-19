package game.world.items.utils 
{
	import game.core.metric.ICoordinated;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class PointsOfInterest implements IPointCollector
	{
		private var types:Array;
		
		public function PointsOfInterest(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.quitGame);
		}
		
		update function prerestore(... args):void
		{
			this.types = new Array();
		}
		
		update function quitGame():void
		{
			this.types = null;
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
			if (length == 0)
				return null;
			
			return vector[int(Math.random() * length)];
		}
		
		public function getPointsOfInterest(type:int):Vector.<ICoordinated>
		{
			return this.types[type];
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
		
	}

}