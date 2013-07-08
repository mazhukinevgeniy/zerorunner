package model.statistics 
{
	import model.SaveBase;
	
	public class Statistic extends SaveBase implements ICollectorsCollector, IStatistic
	{
		private var statistics:Vector.<IStatistic>;
		
		public function Statistic() 
		{
			super();
			
			this.statistics = new Vector.<IStatistic>();
		}
		
		public function reinitialize():void
		{
			for (var i:int; i < this.statistics.length; i++)
				this.statistics[i].reinitialize();
		}
		public function resetSessionRelatedStatistics():void
		{
			for (var i:int; i < this.statistics.length; i++)
				this.statistics[i].resetSessionRelatedStatistics();
		}
		
		public function getAchievements():Vector.<IAchievementEntry>
		{
			var tmp:Vector.<IAchievementEntry> = new Vector.<IAchievementEntry>();
			for (var i:int; i < this.statistics.length; i++)
				tmp += this.statistics[i].getAchievements();
			
			return tmp;
		}
		
		public function getStatistics():Vector.<IStatisticsEntry>
		{
			var tmp:Vector.<IStatisticsEntry> = new Vector.<IStatisticsEntry>();
			for (var i:int; i < this.statistics.length; i++)
				tmp += this.statistics[i].getStatistics();
			
			return tmp;
		}
		
		public function addStatistic(item:IStatistic):void
		{
			this.statistics.push(item);
		}
	}

}