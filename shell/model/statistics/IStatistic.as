package model.statistics 
{
	
	public interface IStatistic extends IKnowAchievements, IKnowStatistics
	{
		function reinitialize():void;
		function resetSessionRelatedStatistics():void;
	}
	
}