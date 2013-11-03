package game.core.metric 
{
	
	public class Metric
	{
		private static const randomDCells:Vector.<DCellXY> = 
			new <DCellXY>[new ProtectedDCellXY(-1, 0), new ProtectedDCellXY(1, 0),
						  new ProtectedDCellXY(0, 1), new ProtectedDCellXY(0, -1)];
		
		
		public static function getRandomDCell():DCellXY 
		{
			return Metric.randomDCells[int(Math.random() * 4)];
		}
		
		public static function distance(p1:ICoordinated, p2:ICoordinated):int
		{
			return Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y)
		}
		
		
		public function Metric() 
		{ 
			throw new Error(); 
		}
	}

}