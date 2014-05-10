package starling.tweaks 
{
	import starling.display.QuadBatch;
	
	internal class PreciseQuadBatch extends QuadBatch
	{
		
		public function PreciseQuadBatch() 
		{
			
		}
		
		
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