package game.achievements 
{
	import game.metric.DCellXY;
	
	public interface IActorStatistic 
	{
		function heroMoved(change:DCellXY):void;
	}
	
}