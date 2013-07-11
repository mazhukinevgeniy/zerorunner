package game.metric 
{
	import chaotic.errors.StaticClassError;
	import chaotic.errors.UnresolvedRequestError;
	
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
			var x:int, y:int;
			
			if (Math.random() < 0.5)
			{	x = 0;
				
				if (Math.random() < 0.5) y = -1;
				else 					 y = 1;		}
			else 
			{	y = 0;
				
				if (Math.random() < 0.5) x = -1;
				else 					 x = 1;		}
			
			return new DCellXY(x, y);
		}
		
		public static function toPixel(item:*):*
		{
			if (item is CellXY)
				return new PixelXY(item.x * Metric.cellWidth, item.y * Metric.cellHeight);
			else if (item is DCellXY)
				return new DPixelXY(item.x * Metric.cellWidth, item.y * Metric.cellHeight);
			else 
				throw new UnresolvedRequestError();
		}
		
		
		
		public static function getHash(cell:CellXY):int
		{
			return uint(uint(cell.x * 426389) ^ uint(cell.y * 514229)) % 512;
		}
		public static function getMaximumHash():int
		{
			return 512;
		}
		
		public static function distance(p1:CellXY, p2:CellXY):int
		{
			return Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y)
		}
	}

}