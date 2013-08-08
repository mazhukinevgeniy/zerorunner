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
			
			texture.repeat = true;
			trace(texture.width, texture.height);
			super(texture);
			
			trace(this.width, this.height);
			
			//this.setTexCoords(0, new Point(0, 0));
			this.setTexCoords(1, new Point(3, 0));
			this.setTexCoords(2, new Point(0, 3));
			this.setTexCoords(3, new Point(3, 3));
			

			
			
			//http://forum.starling-framework.org/topic/texture-repeat-property
			
			
		}
		
	}

}