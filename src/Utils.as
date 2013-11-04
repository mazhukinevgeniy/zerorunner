package  
{
	import game.core.metric.DCellXY;
	import game.core.metric.ProtectedDCellXY;
	
	public class Utils 
	{
		private static const randomDCells:Vector.<DCellXY> = 
			new <DCellXY>[new ProtectedDCellXY(-1, 0), new ProtectedDCellXY(1, 0),
						  new ProtectedDCellXY(0, 1), new ProtectedDCellXY(0, -1)];
		
		
		
		
		public function Utils() 
		{
			throw new Error();
		}
		
		public static function getRandomDCell():DCellXY 
		{
			return Utils.randomDCells[int(Math.random() * 4)];
		}
		
	}

}