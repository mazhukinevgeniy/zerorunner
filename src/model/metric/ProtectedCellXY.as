package model.metric 
{
	/**
	 * Use this class if you want to have reusable CellXYs which are never broken
	 */
	public class ProtectedCellXY extends CellXY 
	{
		
		public function ProtectedCellXY(x:int, y:int) 
		{
			super(x, y);
		}
		
		final override public function setValue(x:int, y:int):void 
		{
			throw new Error();
		}
	}

}