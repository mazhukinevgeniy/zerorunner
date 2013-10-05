package ui.windows.achievements 
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class HexagonalGrid extends Image
	{
		
		private static const NUMBER_OF_TEXTURES_IN_WIDTH:Number = 5;
		private static const NUMBER_OF_TEXTURES_IN_HEIGHT:Number = 7;
		
		private static const DISPLAYED_WIDTH_CELL:Number = 140;
		private static const DISPLAYED_HEIGHT_CELL:Number = 80.5;
		
		private static const HEXAGON_SIZE:Number = HexagonalGrid.DISPLAYED_WIDTH_CELL / 3;
		
		private var nativeWidthCell:Number;
		private var nativeHeightCell:Number;
		
		public function HexagonalGrid(assets:AssetManager) 
		{
			var texture:Texture = assets.getTexture("hexagon");
			
			this.nativeWidthCell = texture.nativeWidth;
			this.nativeHeightCell = texture.nativeHeight;
			
			super(texture);
		
			texture.repeat = true;
			this.setTexCoords(0, new Point(0, 0));
			this.setTexCoords(1, new Point(HexagonalGrid.NUMBER_OF_TEXTURES_IN_WIDTH, 0));
			this.setTexCoords(2, new Point(0, HexagonalGrid.NUMBER_OF_TEXTURES_IN_HEIGHT));
			this.setTexCoords(3, new Point(HexagonalGrid.NUMBER_OF_TEXTURES_IN_WIDTH, HexagonalGrid.NUMBER_OF_TEXTURES_IN_HEIGHT));
			
			this.scaleX *= HexagonalGrid.DISPLAYED_WIDTH_CELL / this.nativeWidthCell;
			this.scaleY *= HexagonalGrid.DISPLAYED_HEIGHT_CELL / this.nativeHeightCell;
			
			this.width *= HexagonalGrid.NUMBER_OF_TEXTURES_IN_WIDTH;
			this.height *= HexagonalGrid.NUMBER_OF_TEXTURES_IN_HEIGHT;
			
			this.y = - HexagonalGrid.HEXAGON_SIZE / 2;
			this.x = - HexagonalGrid.HEXAGON_SIZE / 2;
			
			trace(HexagonalGrid.HEXAGON_SIZE);
			trace(this.nativeWidthCell * (HexagonalGrid.DISPLAYED_WIDTH_CELL / this.nativeWidthCell) / 3);
			

			
			
			//http://forum.starling-framework.org/topic/texture-repeat-property
			
			
		}
		
	}

}