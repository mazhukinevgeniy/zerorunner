package game.items.base 
{
	
	public interface ISolderable 
	{
		function applySoldering(value:int):void;
		
		/**
		 * 0 - no progress, 1 - finished, 2 - finished twice etc
		 */
		function get progress():Number;
	}
	
}