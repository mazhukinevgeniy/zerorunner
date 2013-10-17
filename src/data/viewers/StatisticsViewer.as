package data.viewers 
{
	import flash.utils.Proxy;
	
	public class StatisticsViewer 
	{
		private var save:Proxy;
		
		public function StatisticsViewer(save:Proxy) 
		{
			this.save = save;
		}
		
		
		
		public function get totalDistance():int
		{
			return this.save["distance"];
		}
	}

}