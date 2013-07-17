package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.UpdateManager;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	import game.statistics.ITakeStatistics;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import game.statistics.StatisticsPiece;
	import game.statistics.StatisticsFeature;
	import game.ZeroRunner;
	
	public class StatisticsWindow  extends ScrollContainer implements ITakeStatistics
	{	
		private var flow:IUpdateDispatcher;
		
		public static const WIDTH_STATISTICS_WINDOW:Number = 250;
		public static const MAX_HEIGHT_STATISTICS_WINDOW:Number = 450;
		
		private static const SPACE_BEETWEEN_LIST:Number = 10;
		private static const PAGGING:Number = 10;
		
		private var data:Vector.<DisplayObject>;
		
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
			
			this.data = new Vector.<DisplayObject>();
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(StatisticsFeature.showStatistics);
		}
		
		public function showStatistics():void
		{
			this.removeChildren();
			this.flow.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, StatisticsFeature.emitStatistics, this);
		}
		
		public function takeStatistics(newItem:StatisticsPiece):void
		{
			var list:List = new List();
			this.writeInList(list, newItem);
			this.data.push(new ContainerStatisticsPiece(list));
			this.addChild(this.data[this.data.length - 1]);
		}
		
		private function writeInList(list:List, newItem:StatisticsPiece):void
		{
			var data:Vector.<Object> = new Vector.<Object>;
			list.dataProvider = new ListCollection(data);
			list.itemRendererProperties.labelField = "text";
			
			for (var i:int = 0; i < newItem.length; ++i)
			{
				var string:String = newItem.entry[i];
				data.push( { text: string } );
			}
		}
		
		private function createLayout():VerticalLayout
		{
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = StatisticsWindow.SPACE_BEETWEEN_LIST;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER
			
			return layout;
		}
		
		
		
	}

}