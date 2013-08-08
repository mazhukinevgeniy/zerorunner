package ui.statistics 
{
	import feathers.controls.IScrollBar;
	import feathers.controls.ScrollBar;
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
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	import utils.updates.UpdateManager;

	
	public class StatisticsWindow  extends ScrollContainer implements ITakeStatistics, IDropTarget
	{	
		public static const dropMiss:String = "dropMiss";
		
		public static const COUNT_STATISTICS_PIECE:int = 3;
		public static const WIDTH_STATISTICS_WINDOW:Number = 200;
		public static const MAX_HEIGHT_STATISTICS_WINDOW:Number = 450;
		
		private static const PAGGING:Number = 5;
		
		private var flow:IUpdateDispatcher;
		
		private var data:Vector.<ChunkStatistics>;
		
		private var comeStatisticsPiece:int;
		
		public function StatisticsWindow(flow:IUpdateDispatcher) 
		{
			this.initializationSizeContainer();
			this.initializationBackground();
			this.initializationLayout();
			this.initializationScrollBar();
			this.initializationPlaceForStatisticsPiece();
			this.initializationUsingFlow(flow);
			this.initializationEventListener();
		}
		
		private function initializationSizeContainer():void
		{
			this.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW + 2 * StatisticsWindow.PAGGING;
			this.maxHeight = StatisticsWindow.MAX_HEIGHT_STATISTICS_WINDOW;
		}
		
		private function initializationBackground():void
		{
			var tmp:Quad = new Quad(StatisticsWindow.WIDTH_STATISTICS_WINDOW, 1, 0xFFFFFF);
			
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
		}
		
		private function initializationLayout():void
		{
			var layout:VerticalLayout = new VerticalLayout();
			
			layout.gap = StatisticsWindow.PAGGING;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			this.padding = StatisticsWindow.PAGGING;
			this.layout = layout;
		}
		
		private function initializationScrollBar():void 
		{
			this.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;
			this.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_AUTO;
			this.interactionMode = ScrollContainer.INTERACTION_MODE_MOUSE;
			
			this.verticalScrollBarFactory = function():IScrollBar
			{
				var newScrollBar:ScrollBar = new ScrollBar();
				newScrollBar.direction = ScrollBar.DIRECTION_VERTICAL;
				
				return newScrollBar; 
			}
		}
		
		private function initializationPlaceForStatisticsPiece():void
		{
			this.data = new Vector.<ChunkStatistics>();
			
			this.comeStatisticsPiece = 0;
		}
		
		private function initializationUsingFlow(flow:IUpdateDispatcher):void
		{
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(StatisticsWindow.dropMiss);
		}
		
		private function initializationEventListener():void
		{
			this.addEventListener(DragDropEvent.DRAG_ENTER, this.checkFormat);
			this.addEventListener(DragDropEvent.DRAG_DROP, this.dropContainer);
		}
		
		private function checkFormat(event:DragDropEvent, dragData:DragData):void
		{
			if(dragData.hasDataForFormat(ChunkStatistics.CHUNK_STATISTICS_DRAG_FORMAT))
			{
				DragDropManager.acceptDrag(this);
			}
		}
		
		private function dropContainer(event:DragDropEvent, dragData:DragData):void
		{
			var movedContainer:ChunkStatistics = dragData.getDataForFormat(ChunkStatistics.CHUNK_STATISTICS_DRAG_FORMAT);
			var dataLenght:int = this.data.length;
			var dropY:Number = event.localY;
			
			for (var i:int = 0; i < dataLenght; ++i)
			{
				if (this.isDropInTopHalf(i, dropY))
				{
					this.changeOrderChunk(movedContainer, i - 1);
				}
				else if (this.isDropInBottomHalf(i, dropY))
				{
					this.changeOrderChunk(movedContainer, i);
				}
			}
			
			if (this.isDropInBottomContainer(dropY))
			{
				this.changeOrderChunk(movedContainer, dataLenght - 1);
			}
			
			this.redraw();
		}
		
		private function isDropInTopHalf (indexDropPlace:int, dropY:Number):Boolean
		{
			var yDropPlace:Number = this.data[indexDropPlace].y;
			var heightDropPlace:Number = this.data[indexDropPlace].height;
			var isDrop:Boolean = false;
			
			if (yDropPlace < dropY && dropY <= yDropPlace + (heightDropPlace / 2) )
			{
				isDrop = true;
			}
			
			return isDrop;
		}
		
		private function isDropInBottomHalf (indexDropPlace:int, dropY:Number):Boolean
		{
			var yDropPlace:Number = this.data[indexDropPlace].y;
			var heightDropPlace:Number = this.data[indexDropPlace].height;
			var isDrop:Boolean = false;
			
			if (yDropPlace + (heightDropPlace / 2) < dropY && dropY <= yDropPlace + heightDropPlace )
			{
				isDrop = true;
			}
			
			return isDrop;
		}
		
		private function isDropInBottomContainer (dropY:Number):Boolean
		{
			var isDrop:Boolean = false;
			
			if (this.height - 2 * this.padding < dropY && dropY <= this.height )
			{
				isDrop = true;
			}
			
			return isDrop;
		}
		
		private function changeOrderChunk(movedContainer:ChunkStatistics, indexItemToMove:int = -1):void
		{	
			var lenght:int = this.data.length;
			
			this.data.splice(this.data.indexOf(movedContainer), 1);
			
			if (indexItemToMove == -1)
				this.data.unshift(movedContainer)
			else
				this.data.splice(indexItemToMove, 0, movedContainer);
		}
		
		public override function set visible(newValue:Boolean):void
		{
			if (newValue || this.data.length == 0)
			{
				this.flow.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, StatisticsFeature.emitStatistics, this);
			}
			
			super.visible = newValue;
		}
		
		public function takeStatistics(newItem:StatisticsPiece):void
		{
			this.updateData(newItem);
			this.comeStatisticsPiece++;
			
			if (this.comeStatisticsPiece == StatisticsWindow.COUNT_STATISTICS_PIECE)
			{
				this.comeStatisticsPiece = 0;
				this.redraw();
			}
		}
		
		private function updateData(newItem:StatisticsPiece):void
		{
			
			if (this.isExistItemInData(newItem))
			{
				this.updateDataInChunk(newItem);
			}
			else
			{
				this.createAndPushChunk(newItem);
			}
		}
		
		private function isExistItemInData(newItem:StatisticsPiece):Boolean
		{
			var isExist:Boolean = false;
			
			for (var i:int = 0; i < this.data.length;  ++i)
			{
				if (this.data[i] != null && this.data[i].title == newItem.title)
				{
					isExist = true;
					break;
				}
			}
			
			return isExist;
		}
		
		private function updateDataInChunk(newItem:StatisticsPiece):void
		{
			for (var i:int = 0; i < this.data.length;  ++i)
			{
				if (this.data[i] != null && this.data[i].title == newItem.title)
				{
					this.data[i].updateData(newItem);
					break;
				}
			}
		}
		
		private function createAndPushChunk(newItem:StatisticsPiece):void
		{
			var newChunk:ChunkStatistics = new ChunkStatistics(newItem, this.flow)
			var order:int = newChunk.order;
			
			if (order != -1)
			{
				this.data[order] = newChunk;
			}
			else
			{
				this.data.push(newChunk);
			}
		}
		
		private function redraw():void
		{
			var lenght:int = this.data.length;
			
			this.removeChildren();
			
			for (var i:int = 0;  i < lenght; ++i)
			{
				this.addChild(this.data[i]);
				this.data[i].order = i;
			}
		}
		
		update function dropMiss():void
		{
			this.redraw();
		}
		
		
	}

}