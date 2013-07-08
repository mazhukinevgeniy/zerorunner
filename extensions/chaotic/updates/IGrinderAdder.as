package chaotic.updates 
{
	import chaotic.grinder.GrindingStream;
	
	public interface IGrinderAdder 
	{
		function addGrinders(vector:Vector.<GrindingStream>):void;
	}
	
}