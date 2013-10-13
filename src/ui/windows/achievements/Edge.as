package ui.windows.achievements 
{
	import flash.geom.Point;
	import starling.display.Quad;
	
	public class Edge extends Quad
	{
		private static const WIDTH:Number = 3;
		
		public function Edge(point:Point) 
		{
			var start:int = (int)(point.x);
			var end:int = (int)(point.y);
			
			var xOfCell:int = start % HexagonalGrid.NUMBER_OF_CELL_IN_WIDTH;
			var yOfCell:int = (int)(start / HexagonalGrid.NUMBER_OF_CELL_IN_WIDTH);
			
			super(Edge.WIDTH, 100);
			
			
			
			this.x = HexagonalGrid.OFFSET_X + (0.5 + xOfCell * 0.75) * HexagonalGrid.HEXAGONAL_WIDTH;
			this.y = HexagonalGrid.OFFSET_Y + (yOfCell + 0.5) * HexagonalGrid.HEXAGONAL_HEIGHT;
			
			if (xOfCell % 2 == 1)
				this.y += 0.5 * HexagonalGrid.HEXAGONAL_HEIGHT;
		}
		
	}

}