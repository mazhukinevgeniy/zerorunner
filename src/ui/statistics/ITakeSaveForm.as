package ui.statistics 
{
	public interface ITakeSaveForm
	{
		function get title():String
		function takeSave(number:int, roll:Boolean, fix:Boolean):void
	}
	
}