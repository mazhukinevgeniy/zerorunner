package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import feathers.controls.ScrollContainer;
	import starling.display.Quad;
	
	public class StatisticsWindow  extends ScrollContainer
	{	
		private var flow:IUpdateDispatcher;
		
		public static const WIDTH_STATISTICS_WINDOW:Number = 250;
		public static const HEIGHT_STATISTICS_WINDOW:Number = 250;
		
		public function StatisticsWindow(flow:IUpdateDispatcher, name:String = "StatisticsWindow") 
		{
			this.name =  name;
			
			this.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.height = StatisticsWindow.HEIGHT_STATISTICS_WINDOW;
			
			var tmp:Quad = new Quad(StatisticsWindow.WIDTH_STATISTICS_WINDOW, StatisticsWindow.HEIGHT_STATISTICS_WINDOW, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.visible = false;
			
			this.flow = flow;
		}
		
	}

}