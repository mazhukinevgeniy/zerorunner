package game.metric 
{
	import utils.errors.StaticClassError;
	
	public class Metric
	{
		private static var cellWidth:int;
		private static var cellHeight:int;
		
		private static var cellsInVisibleWidth:int;
		private static var cellsInVisibleHeigth:int;
		
		private static var width:int;
		private static var height:int;
		
		public static function get CELL_WIDTH():int { return Metric.cellWidth; }
		public static function get CELL_HEIGHT():int { return Metric.cellWidth; }
		
		public static function get CELLS_IN_VISIBLE_WIDTH():int { return Metric.cellsInVisibleWidth; }
		public static function get CELLS_IN_VISIBLE_HEIGHT():int { return Metric.cellsInVisibleHeigth; }
		
		public static function get WIDTH():int { return Metric.width; }
		public static function get HEIGHT():int { return Metric.height; }
		
		private static var randomDCells:Vector.<DCellXY> = new <DCellXY>[new DCellXY(-1, 0), new DCellXY(1, 0), new DCellXY(0,1), new DCellXY(0, -1)];
		
		public function Metric() 
		{
			throw new StaticClassError();
		}
		
		public static function initialize(cW:int = 24, cH:int = 24, tW:int = 81, tH:int = 81):void
		{
			if (Metric.cellWidth != 0) throw new Error();
			
			Metric.cellWidth = cW;
			Metric.cellHeight = cH;
			Metric.width = tW;
			Metric.height = tH;
			
			Metric.cellsInVisibleWidth = int(Main.WIDTH / Metric.cellWidth);
			Metric.cellsInVisibleHeigth = int(Main.HEIGHT / Metric.cellHeight);
		}
		
		public static function getRandomDCell():DCellXY 
		{
			return Metric.randomDCells[int(Math.random() * 4)];
		}
		
		public static function distance(p1:ICoordinated, p2:ICoordinated):int
		{
			return Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y)
		}
	}

}