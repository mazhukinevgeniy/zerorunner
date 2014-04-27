package game.input 
{
	import game.metric.DCellXY;
	
	public interface IKnowInput 
	{
		function getInputCopy():Vector.<DCellXY>;
		
		function isSpacePressed():Boolean;
		function isThereInput():Boolean;
	}
	
}