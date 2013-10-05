package game.core.metric 
{
	
	public class Metric
	{
		public static const CELL_WIDTH:int = 40;
		public static const CELL_HEIGHT:int = 40;
		
		public static const CELLS_IN_VISIBLE_WIDTH:int = int(Main.WIDTH / Metric.CELL_WIDTH);
		public static const CELLS_IN_VISIBLE_HEIGHT:int = int(Main.HEIGHT / Metric.CELL_HEIGHT);
		
		private static const randomDCells:Vector.<DCellXY> = new <DCellXY>[new DCellXY(-1, 0), new DCellXY(1, 0), new DCellXY(0,1), new DCellXY(0, -1)];
		
		
		public static function getRandomDCell():DCellXY 
		{
			return Metric.randomDCells[int(Math.random() * 4)];
		}
		
		public static function distance(p1:ICoordinated, p2:ICoordinated):int
		{
			return Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y)
		}
		
		
		/**
		 * Global helper
		 */
		
		private static const tmpCell:CellXY = new CellXY(0, 0);
		private static const tmpDCell:DCellXY = new DCellXY(0, 0);
		
		public static function getTmpCell(x:int, y:int):CellXY
		{
			Metric.tmpCell._x = x;
			Metric.tmpCell._y = y;
			
			return Metric.tmpCell;
		}
		
		public static function getTmpDCell(x:int, y:int):DCellXY
		{
			Metric.tmpDCell._x = x;
			Metric.tmpDCell._y = y;
			
			return Metric.tmpDCell;
		}
		
		
		public function Metric() 
		{ 
			throw new Error(); 
		}
	}

}