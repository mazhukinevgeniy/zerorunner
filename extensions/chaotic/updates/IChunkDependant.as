package chaotic.updates 
{
	import chaotic.metric.DCellXY;
	
	public interface IChunkDependant 
	{
		function moveChunks(change:DCellXY):void;
	}
	
}