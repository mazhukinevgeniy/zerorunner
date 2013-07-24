package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.core.UpdateManager;
	import feathers.controls.ScrollContainer;
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.DragDropManager;
	import feathers.dragDrop.IDropTarget;
	import feathers.events.DragDropEvent;
	import feathers.layout.VerticalLayout;
	import game.statistics.ITakeStatistics;
	import starling.display.Quad;
	import game.statistics.StatisticsPiece;
	import game.statistics.StatisticsFeature;
	import game.ZeroRunner;

	
	public class StatisticsWindow  extends ScrollContainer implements ITakeStatistics, IDropTarget
	{	
		public static const dropMiss:String = "dropMiss";
		
		public static const WIDTH_STATISTICS_WINDOW:Number = 200;
		public static const MAX_HEIGHT_STATISTICS_WINDOW:Number = 450;
		
		private static const PAGGING:Number = 5;
		
		private var flow:IUpdateDispatcher;
		
		private var data:Vector.<ChunkList>;
		
		private var lastTouchIndex:int;
		private var movedContainer:ChunkList;
		private var isDragging:Boolean;
		
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
			
			this.data = new Vector.<ChunkList>();
			
			this.isDragging = false;
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(StatisticsFeature.showStatistics);
			this.flow.addUpdateListener(StatisticsWindow.dropMiss);
			
			this.addEventListener(DragDropEvent.DRAG_ENTER, this.checkFormat);
			this.addEventListener(DragDropEvent.DRAG_DROP, this.dropContainer);
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
		
		update function showStatistics():void
		{
			this.flow.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, StatisticsFeature.emitStatistics, this);
		}
		
		update function dropMiss():void
		{
			this.redraw();
		}
		
		private function redraw(movedContainer:ChunkList = null, indexItemToMove:int = -1):void
		{	
			var lenght:int = this.data.length;
			
			if (movedContainer != null)
			{
				this.data.splice(this.data.indexOf(movedContainer), 1);
				
				if (indexItemToMove == -1)
					this.data.unshift(movedContainer)
				else
					this.data.splice(indexItemToMove, 0, movedContainer);
				
				this.removeChildren();
			}
				
			
			for (var i:int = 0;  i < lenght; ++i)
			{
				this.addChild(this.data[i]);
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
				this.data.push(new ChunkList(newItem, this.flow));
		}
		
		private function createLayout():VerticalLayout
		{
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = StatisticsWindow.PAGGING;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			layout.padding = StatisticsWindow.PAGGING;
			
			return layout;
		}
		
		private function checkFormat(event:DragDropEvent, dragData:DragData):void
		{
			if(dragData.hasDataForFormat("display-object-drag-format"))
			{
				DragDropManager.acceptDrag(this);
			}
		}
		
		private function dropContainer(event:DragDropEvent, dragData:DragData):void
		{
			var movedContainer:ChunkList = dragData.getDataForFormat("display-object-drag-format");
			var statisticsPieceY:Number;
			var statisticsPieceHeight:Number;
			
			for (var i:int = 0; i < this.data.length; ++i)
			{
				statisticsPieceY = this.data[i].y;
				statisticsPieceHeight = this.data[i].height;
				
				if (statisticsPieceY - StatisticsWindow.PAGGING < event.localY &&
					event.localY <= statisticsPieceY + (statisticsPieceHeight / 2) )
				{
					this.redraw(movedContainer, i - 1);
				}
				else if (statisticsPieceY + (statisticsPieceHeight / 2) < event.localY &&
						 event.localY <= statisticsPieceY + statisticsPieceHeight )
				{
					this.redraw(movedContainer, i);
				}
			}
		}
		
	}

}