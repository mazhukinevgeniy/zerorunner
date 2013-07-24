package game.achievements.statistics 
{
	import game.metric.DCellXY;
	
	public interface IActorStatistic 
	{
		function heroMoved(change:DCellXY):void;
	}
	
}