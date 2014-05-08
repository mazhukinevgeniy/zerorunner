package model.interfaces 
{
	import model.metric.DCellXY;
	
	public interface IInput 
	{
		function getInputCopy():Vector.<DCellXY>;
		
		function isThereInput():Boolean;
		function isActionRequested(action:int):Boolean;
	}
	
}