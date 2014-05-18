package starling.extensions 
{
	import feathers.controls.text.BitmapFontTextRenderer;
	import starling.core.RenderSupport;
	import starling.text.BitmapChar;
	
	public class PreciseBitmapFontTextRenderer extends BitmapFontTextRenderer
	{
		
		public function PreciseBitmapFontTextRenderer() 
		{
			
		}
		override protected function initialize():void
		{
			if(!this._characterBatch)
			{
				this._characterBatch = new PreciseQuadBatch();
				this._characterBatch.touchable = false;
				this.addChild(this._characterBatch);
			}
			else
				throw new Error("can't be precise");
		}
		
		/* Idk, the class works without it. */
		/*override protected function addCharacterToBatch(charData:BitmapChar, x:Number, y:Number, scale:Number, support:RenderSupport = null, parentAlpha:Number = 1):void 
		{
			x = Math.round(x);
			y = Math.round(y);
			
			super.addCharacterToBatch(charData, x, y, scale, support, parentAlpha);
		}*/
		
		override public function set x(value:Number):void 
		{
			super.x = Math.round(value);
		}
		
		override public function set y(value:Number):void 
		{
			super.y = Math.round(value);
		}
	}

}