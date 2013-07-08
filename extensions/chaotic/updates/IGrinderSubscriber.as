package chaotic.updates 
{
	
	public interface IGrinderSubscriber
	{
		function grindingStreamMoved(id:int, change:int):void;
	}
	
}