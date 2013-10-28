package game.core.metric 
{
	/**
	 * Use this class if you want to have reusable DCellXYs which are never broken
	 */
	public class ProtectedDCellXY extends DCellXY 
	{
		
		public function ProtectedDCellXY(x:int, y:int) 
		{
			super(x, y);
		}
		
		final override public function setValue(x:int, y:int):void 
		{
			throw new Error();
		}
	}

}