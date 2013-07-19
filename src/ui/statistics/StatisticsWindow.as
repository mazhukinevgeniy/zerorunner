package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.core.UpdateManager;
	import feathers.controls.ScrollContainer;
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.DragDropManager;
	import feathers.dragDrop.IDropTarget;
	import feathers.layout.VerticalLayout;
	import game.statistics.ITakeStatistics;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import game.statistics.StatisticsPiece;
	import game.statistics.StatisticsFeature;
	import game.ZeroRunner;
	import starling.events.Touch;
	
	public class StatisticsWindow  extends ScrollContainer implements ITakeStatistics, IDropTarget
	{	
		public static const moveStatisticsPiece:String = "moveStatisticsPiece";
		
		public static const WIDTH_STATISTICS_WINDOW:Number = 200;
		public static const MAX_HEIGHT_STATISTICS_WINDOW:Number = 450;
		
		private static const SPACE_BEETWEEN_LIST:Number = 5;
		private static const PAGGING:Number = 5;
		
		private var flow:IUpdateDispatcher;
		
		private var data:Vector.<ContainerStatisticsPiece>;
		
		private var dragDropManager:DragDropManager;
		
		public function StatisticsWindow(flow:IUpdateDispatcher, name:String = "StatisticsWindow") 
		{
			this.name =  name;
			
			this.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW + 2 * StatisticsWindow.PAGGING;
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
			this.flow.addUpdateListener(StatisticsWindow.moveStatisticsPiece);
			
			this.dragDropManager = new DragDropManager();
		}
		
		update function showStatistics():void
		{
			this.flow.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, StatisticsFeature.emitStatistics, this);
		}
		
		public function takeStatistics(newItem:StatisticsPiece):void
		{
			var lastIndex:int;
			
			this.updateData(newItem);
			lastIndex = this.data.length - 1;
			if (this.getChildIndex(this.data[lastIndex]) == -1)
			{
				this.addChild(this.data[lastIndex]);
			}
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
				this.data.push(new ContainerStatisticsPiece(newItem, this.flow));
		}
		
		private function createLayout():VerticalLayout
		{
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = StatisticsWindow.SPACE_BEETWEEN_LIST;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			layout.padding = StatisticsWindow.PAGGING;
			
			return layout;
		}
		
		update function moveStatisticsPiece(moved:ContainerStatisticsPiece, touch:Touch):void
		{
			var dragData:DragData = new DragData();
			dragData.setDataForFormat("display-object-drag-format", ContainerStatisticsPiece);
			DragDropManager.startDrag(moved, touch, dragData, moved);
		}
		
	}

}