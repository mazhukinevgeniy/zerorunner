package game.metric 
{
	import utils.errors.StaticClassError;
	
	public class Metric
	{
		private static var cellWidth:int;
		private static var cellHeight:int;
		
		private static var cellsInVisibleWidth:int;
		private static var cellsInVisibleHeigth:int;
		
		public static function get CELL_WIDTH():int { return Metric.cellWidth; }
		public static function get CELL_HEIGHT():int { return Metric.cellWidth; }
		
		public static function get CELLS_IN_VISIBLE_WIDTH():int { return Metric.cellsInVisibleWidth; }
		public static function get CELLS_IN_VISIBLE_HEIGHT():int { return Metric.cellsInVisibleHeigth; }
		
		private static var randomDCells:Vector.<DCellXY> = new <DCellXY>[new DCellXY(-1, 0), new DCellXY(1, 0), new DCellXY(0,1), new DCellXY(0, -1)];
		
		public function Metric() 
		{
			throw new StaticClassError();
		}
		
		public static function initialize(cW:int = 24, cH:int = 24):void
		{
			if (Metric.cellWidth != 0) throw new Error();
			
			Metric.cellWidth = cW;
			Metric.cellHeight = cH;
			
			Metric.cellsInVisibleWidth = int(Main.WIDTH / Metric.cellWidth);
			Metric.cellsInVisibleHeigth = int(Main.HEIGHT / Metric.cellHeight);
			
			Metric.tmpCell = new CellXY(0, 0);
			Metric.tmpDCell = new DCellXY(0, 0);
		}
		
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
		
		private static var tmpCell:CellXY;
		private static var tmpDCell:DCellXY;
		
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
	}

}