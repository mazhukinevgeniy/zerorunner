package view.utils 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class CenteredImage extends Image 
	{
		private var _offX:int;
		private var _offY:int;
		private var _width:int;
		private var _height:int;
		
		
		public function CenteredImage(name:String, assets:AssetManager) 
		{
			var texture:Texture = assets.getTextureAtlas("sprites").getTexture(name);
			
			var offsets:XMLList = assets.getXml("offsets")[name];
			
			this._offX = offsets.xOffset;
			this._offY = offsets.yOffset;
			
			this._width = offsets.width;
			this._height = offsets.height;
			
			super(texture);
		}
		
		override public function get width():Number 
		{
			return this._width;
		}
		
		override public function set width(value:Number):void 
		{
			throw new Error();
		}
		
		override public function get height():Number 
		{
			return this._height;
		}
		
		override public function set height(value:Number):void 
		{
			throw new Error();
		}
		
		/* Danger! Set once. */
		override public function set x(value:Number):void
		{
			super.x = value + this._offX;
		}
		
		override public function set y(value:Number):void
		{
			super.y = value + this._offY;
		}
	}

}