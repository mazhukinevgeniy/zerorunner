package game.input 
{
	import game.metric.DCellXY;
	
	public interface IKnowInput 
	{
		function getInputCopy():Vector.<DCellXY>;
		
		function isFlightToggled():Boolean;
		
		function isThereInput():Boolean;
	}
	
}