package chaotic.updates 
{
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	
	public interface IActorsSubscriber
	{
		function moveActor(number:int, change:DCellXY, ticksToGo:int):void;
		function jumpedActor(id:int, change:DCellXY, ticksToGo:int):void;
		function detonateActor(id:int):void;
	}
	
}