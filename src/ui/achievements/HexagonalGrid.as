package ui.achievements 
{
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.Polygon;
	import starling.textures.Texture;
	
	public class HexagonalGrid extends Sprite
	{
		
		private static const HEXAGON_SIZE:Number = 49;
		private static const NUMBER_EDGES:int = 6;
		private static const HEXAGON_BACKGROUND:uint = 0xff9911;
		
		private static const GRID_COLOR:uint = 0xff000000;
		
		private static const WIDTH_CELL:Number = 2 * HexagonalGrid.HEXAGON_SIZE + 2;
		private static const HEIGHT_CELL:Number = 2 * Math.sqrt(HexagonalGrid.HEXAGON_SIZE * HexagonalGrid.HEXAGON_SIZE * (3 / 4)) + 2;
		
		
		public function HexagonalGrid() 
		{
			this.initializationGridBackground();
			this.initializationPolygons();
		}
		
		private function initializationGridBackground():void
		{
			var texture:Texture = Texture.fromColor(AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW,
													AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW,
													HexagonalGrid.GRID_COLOR)
			var background:Image = new Image(texture);
			this.addChild(background);
		}
		
		private function initializationPolygons():void
		{
			var widthInPolygons:int = this.width / (HexagonalGrid.WIDTH_CELL);
			var heightInPolygons:int = this.height / (HexagonalGrid.HEIGHT_CELL / 2);
			
			for (var i:int = 0; i < widthInPolygons; ++i)
			{
				for (var j:int = 0; j < heightInPolygons; ++j)
				{
					var hexagon:Polygon;
					if ( j % 2 == 0)
					{
						hexagon = this.createHexagon(i * (HexagonalGrid.WIDTH_CELL + 0.5 * HexagonalGrid.WIDTH_CELL), j * (HexagonalGrid.HEIGHT_CELL / 2));
					}
					else
					{
						hexagon = this.createHexagon(i * (HexagonalGrid.WIDTH_CELL + HexagonalGrid.HEXAGON_SIZE) + 0.75 * HexagonalGrid.WIDTH_CELL, j * (HexagonalGrid.HEIGHT_CELL / 2));
					}
					this.addChild(hexagon);
				}
			}
		}
		
		private function createHexagon(x:Number = 0, y:Number = 0):Polygon
		{
			var polygon:Polygon = new Polygon(HexagonalGrid.HEXAGON_SIZE, HexagonalGrid.NUMBER_EDGES, HexagonalGrid.HEXAGON_BACKGROUND);
			polygon.x = x + HexagonalGrid.WIDTH_CELL / 2;
			polygon.y = y + HexagonalGrid.HEIGHT_CELL / 2;
			
			return polygon;
		}
		
	}

}