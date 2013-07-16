package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import starling.display.Quad;
	import game.statistics.StatisticsPiece;
	import game.statistics.StatisticsFeature;
	
	public class StatisticsWindow  extends List
	{	
		private var flow:IUpdateDispatcher;
		
		public static const WIDTH_STATISTICS_WINDOW:Number = 250;
		public static const HEIGHT_STATISTICS_WINDOW:Number = 250;
		
		private var data:Vector.<List>;
		
		public function StatisticsWindow(flow:IUpdateDispatcher, name:String = "StatisticsWindow") 
		{
			this.name =  name;
			
			this.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.height = StatisticsWindow.HEIGHT_STATISTICS_WINDOW;
			
			var tmp:Quad = new Quad(StatisticsWindow.WIDTH_STATISTICS_WINDOW, StatisticsWindow.HEIGHT_STATISTICS_WINDOW, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.visible = false;
			
			this.data = new Vector.<List>();
			this.dataProvider = new ListCollection(this.list);
			
			this.itemRendererProperties.list = "text";
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(StatisticsFeature.takeStatistics);
		}
		
		public function takeStatistics(newItem:StatisticsPiece)
		{
			var list:List = new List();
			//== to be continue
		}
		
		
		
	}

}