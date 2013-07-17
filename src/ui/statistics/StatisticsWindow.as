package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.UpdateManager;
	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;
	import game.statistics.ITakeStatistics;
	import starling.display.Quad;
	import game.statistics.StatisticsPiece;
	import game.statistics.StatisticsFeature;
	import game.ZeroRunner;
	
	public class StatisticsWindow  extends ScrollContainer implements ITakeStatistics
	{	
		private var flow:IUpdateDispatcher;
		
		public static const WIDTH_STATISTICS_WINDOW:Number = 200;
		public static const MAX_HEIGHT_STATISTICS_WINDOW:Number = 450;
		
		private static const SPACE_BEETWEEN_LIST:Number = 10;
		private static const PAGGING:Number = 10;
		
		private var data:Vector.<ContainerStatisticsPiece>;
		
		public function StatisticsWindow(flow:IUpdateDispatcher, name:String = "StatisticsWindow") 
		{
			this.name =  name;
			
			this.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.maxHeight = StatisticsWindow.MAX_HEIGHT_STATISTICS_WINDOW;
			
			var tmp:Quad = new Quad(StatisticsWindow.WIDTH_STATISTICS_WINDOW, 1, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.visible = false;
			this.layout = this.createLayout();
			
			this.data = new Vector.<ContainerStatisticsPiece>();
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(StatisticsFeature.showStatistics);
		}
		
		public function showStatistics():void
		{
			this.flow.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, StatisticsFeature.emitStatistics, this);
		}
		
		public function takeStatistics(newItem:StatisticsPiece):void
		{
			var lastIndex:int;
			
			this.updateData(newItem);
			lastIndex = this.data.length - 1;
			if(this.getChildIndex(this.data[lastIndex]) == -1)
				this.addChild(this.data[lastIndex]);
		}
		
		private function updateData(newItem:StatisticsPiece):void
		{
			var isPiece:Boolean = false;
			
			for (var i:int = 0; i < this.data.length;  ++i)
			{
				if (this.data[i].title == newItem.title)
				{
					isPiece = true;
					this.data[i].updateData(newItem);
					break;
				}
			}
			
			if (!isPiece)
				this.data.push(new ContainerStatisticsPiece(newItem));
		}
		
		private function createLayout():VerticalLayout
		{
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = StatisticsWindow.SPACE_BEETWEEN_LIST;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			
			return layout;
		}
		
		
		
	}

}