package view.shell.windows.achievements 
{
	import flash.geom.Point;
	import starling.display.Quad;
	
	public class Edge extends Quad
	{
		private static const WIDTH:Number = 3;
		private static const HEIGHT:Number = HexagonalGrid.HEXAGONAL_HEIGHT;
		
		public function Edge(point:Point) 
		{
			var start:int = (int)(point.x);
			var end:int = (int)(point.y);
			var difference:int = end - start;
			var coefficient:int;
			var xMod2:int = (int)(point.x) % 2;
			var widthInCells:int = HexagonalGrid.NUMBER_OF_CELL_IN_WIDTH;
			
			var xOfCell:int = start % HexagonalGrid.NUMBER_OF_CELL_IN_WIDTH;
			var yOfCell:int = (int)(start / HexagonalGrid.NUMBER_OF_CELL_IN_WIDTH);
			
			var height:Number;

			if(difference == -widthInCells)
				height = -Edge.HEIGHT;
			else 
				height = Edge.HEIGHT;
				
			super(Edge.WIDTH, height);
			
			this.x = HexagonalGrid.OFFSET_X + (0.5 + xOfCell * 0.75) * HexagonalGrid.HEXAGONAL_WIDTH - this.width / 2;
			this.y = HexagonalGrid.OFFSET_Y + (yOfCell + 0.5) * HexagonalGrid.HEXAGONAL_HEIGHT;
			
			if (xOfCell % 2 == 1)
				this.y += 0.5 * HexagonalGrid.HEXAGONAL_HEIGHT;
				
			if (difference == widthInCells - 1 || (difference == -1 && xMod2 == 0))
				coefficient = 1;
			else if (difference == widthInCells + 1 || (difference == 1 && xMod2 == 0))
				coefficient = -1;
			else if (difference == -(widthInCells - 1) || (difference == 1 && xMod2 == 1))
				coefficient = -2;
			else if (difference == -(widthInCells + 1) || (difference == -1 && xMod2 == 1))
				coefficient = 2;
				
			this.rotation = coefficient * Math.PI / 3;
		}
		
	}

}