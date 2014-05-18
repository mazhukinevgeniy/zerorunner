package starling.extensions 
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class CenteredImage extends Image 
	{
		private var _offX:int;
		private var _offY:int;
		private var _width:int;
		private var _height:int;
		
		
		public function CenteredImage(texture:Texture, offsets:XMLList) 
		{
			this._offX = int(offsets.xOffset);
			this._offY = int(offsets.yOffset);
			
			this._width = int(offsets.width);
			this._height = int(offsets.height);
			
			super(texture);
		}
		
		override public function get width():Number 
		{
			return this._width * this.scaleX;
		}
		
		override public function set width(value:Number):void 
		{
			throw new Error();
		}
		
		override public function get height():Number 
		{
			return this._height * this.scaleY;
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