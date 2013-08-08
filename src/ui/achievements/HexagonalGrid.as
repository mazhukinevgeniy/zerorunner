package ui.achievements 
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class HexagonalGrid extends Image
	{
		
		public function HexagonalGrid(assets:AssetManager) 
		{
			var texture:Texture = assets.getTexture("hexagon");
			
			trace(texture.width, texture.height);
			super(texture);
			
			texture.repeat = true;
			
			this.setTexCoords(1, new Point(5, 0));
			this.setTexCoords(2, new Point(0, 7));
			this.setTexCoords(3, new Point(5, 7));
			
			this.width *= 5;
			this.height *= 7;
			
			this.y = -26;
			this.x = -20;
			this.scaleX *= 1.094;
			this.scaleY *= 1.266;

			
			
			//http://forum.starling-framework.org/topic/texture-repeat-property
			
			
		}
		
	}

}