package game.actors.statistics 
{
	import game.metric.DCellXY;
	
	public interface IActorStatistic 
	{
		function heroMoved(change:DCellXY):void;
	}
	
}