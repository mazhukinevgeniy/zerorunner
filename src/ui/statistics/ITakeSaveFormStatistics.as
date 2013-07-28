package ui.statistics 
{
	public interface ITakeSaveFormStatistics 
	{
		function get title():String
		function takeSave(number:int, roll:Boolean, fix:Boolean):void
	}
	
}