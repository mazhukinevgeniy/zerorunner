package ui.achievements 
{
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.Polygon;
	import starling.textures.Texture;
	
	public class HexagonalGrid extends Sprite
	{	
		private static const NUMBER_POLYGONS_IN_HEIGHT:Number = AchievementsWindow.NUMBER_CELLS_IN_HEIGHT + 0.8;
		
		private static const HEIGHT_CELL:Number = (Main.HEIGHT / HexagonalGrid.NUMBER_POLYGONS_IN_HEIGHT) - HexagonalGrid.GAP; //2 * Math.sqrt(HexagonalGrid.HEXAGON_SIZE * HexagonalGrid.HEXAGON_SIZE * (3 / 4));
		private static const HEXAGON_SIZE:Number = HexagonalGrid.HEIGHT_CELL / Math.sqrt(3); //54.3;
		private static const WIDTH_CELL:Number = 2 * HexagonalGrid.HEXAGON_SIZE;
		
		private static const GAP:Number = 2;
		private static const PADDING_IN_POLYGONS:int = 2;
		private static const NUMBER_OF_EDGES:int = 6;
		private static const HEXAGON_BACKGROUND:uint = 0xff9911;
		private static const GRID_COLOR:uint = 0xff000000;
		
		public function HexagonalGrid() 
		{
			this.initializationGridBackground();
			this.initializationPolygons();
			
			trace("size", HexagonalGrid.HEXAGON_SIZE);
			trace("height", HexagonalGrid.HEIGHT_CELL);
			trace("width", HexagonalGrid.WIDTH_CELL);
			trace("gap", HexagonalGrid.GAP);
			trace("number 5 x 8");
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
			var widthCellPlusGap:Number =  HexagonalGrid.WIDTH_CELL + HexagonalGrid.GAP;
			var heightCellPlusGap:Number = HexagonalGrid.HEIGHT_CELL + HexagonalGrid.GAP;
			var widthInPolygons:int = 8 + HexagonalGrid.PADDING_IN_POLYGONS;
			var heightInPolygons:int = 2 * (AchievementsWindow.NUMBER_CELLS_IN_HEIGHT + HexagonalGrid.PADDING_IN_POLYGONS);
			
			for (var i:int = 0; i < widthInPolygons; ++i)
			{
				for (var j:int = 0; j < heightInPolygons; ++j)
				{
					var hexagon:Polygon;
					
					if ( j % 2 == 0)
					{
						hexagon = this.createHexagon(i * 1.5 * widthCellPlusGap, j * (heightCellPlusGap / 2));
					}
					else
					{
						hexagon = this.createHexagon(i * 1.5 * widthCellPlusGap + 0.75 * widthCellPlusGap, j * (heightCellPlusGap / 2));
					}
					this.addChild(hexagon);
				}
			}
		}
		
		private function createHexagon(x:Number = 0, y:Number = 0):Polygon
		{
			var polygon:Polygon = new Polygon(HexagonalGrid.HEXAGON_SIZE, HexagonalGrid.NUMBER_OF_EDGES, HexagonalGrid.HEXAGON_BACKGROUND);
			polygon.x = x;
			polygon.y = y - HexagonalGrid.HEXAGON_SIZE * 2 / 3;
			
			return polygon;
		}
		
	}

}