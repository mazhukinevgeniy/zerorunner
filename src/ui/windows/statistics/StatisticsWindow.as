package ui.windows.statistics 
{
	import feathers.controls.IScrollBar;
	import feathers.controls.ScrollBar;
	import feathers.controls.ScrollContainer;
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.DragDropManager;
	import feathers.dragDrop.IDropTarget;
	import feathers.events.DragDropEvent;
	import feathers.layout.VerticalLayout;
	import progress.statistics.IStatistic;
	import starling.display.Quad;
	import starling.events.Event;
	import ui.navigation.Menu;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;

	
	public class StatisticsWindow  extends ScrollContainer implements IDropTarget
	{	
		public static const COUNT_STATISTICS_PIECE:int = 1;
		public static const WIDTH_STATISTICS_WINDOW:Number = 200;
		public static const MAX_HEIGHT_STATISTICS_WINDOW:Number = 450;
		
		private static const PAGGING:Number = 5;
		
		private var lastHeight:Number;
		
		private var flow:IUpdateDispatcher;
		
		private var data:Vector.<ChunkStatistics>;
		
		private var statistics:IStatistic;
		private var namesOfStatistics:Vector.<String>;
		
		public function StatisticsWindow(flow:IUpdateDispatcher, statistics:IStatistic) 
		{
			this.initializeSizeContainer();
			this.initializeBackground();
			this.initializeLayout();
			this.initializeScrollBar();
			this.initializePlaceForStatisticsPiece(statistics);
			this.initializeUsingFlow(flow);
			this.initializeEventListener();
		}
		
		private function initializeSizeContainer():void
		{
			this.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW + 2 * StatisticsWindow.PAGGING;
			this.maxHeight = StatisticsWindow.MAX_HEIGHT_STATISTICS_WINDOW;
			
			this.lastHeight = 0;
		}
		
		private function initializeBackground():void
		{
			var tmp:Quad = new Quad(StatisticsWindow.WIDTH_STATISTICS_WINDOW, 1, 0xFFFFFF);
			
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
		}
		
		private function initializeLayout():void
		{
			var layout:VerticalLayout = new VerticalLayout();
			
			layout.gap = StatisticsWindow.PAGGING;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			this.padding = StatisticsWindow.PAGGING;
			this.layout = layout;
		}
		
		private function initializeScrollBar():void 
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
		
		private function initializePlaceForStatisticsPiece(statistics:IStatistic):void
		{
			this.data = new Vector.<ChunkStatistics>();
			
			this.statistics = statistics;
			this.namesOfStatistics = this.statistics.namesOfStatistics;
		}
		
		private function initializeUsingFlow(flow:IUpdateDispatcher):void
		{
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.dropMiss);
		}
		
		private function initializeEventListener():void
		{
			this.addEventListener(DragDropEvent.DRAG_ENTER, this.checkFormat);
			this.addEventListener(DragDropEvent.DRAG_DROP, this.dropContainer);
			this.addEventListener(Event.ADDED, this.alignCenter);
			this.addEventListener(Event.RESIZE, this.alignCenter);
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
		
		private function alignCenter():void
		{
			if (this.lastHeight != this.height)
			{
				this.x = (Main.WIDTH + Menu.WIDTH_MENU - this.width) / 2;
				this.y = (Main.HEIGHT - this.height) / 2;
				this.lastHeight = this.height;
			}
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
			if (newValue)
			{
				this.updateData();
				this.redraw();
			}
			
			super.visible = newValue;
		}
		
		private function updateData():void
		{
			for (var i:int = 0; i < StatisticsWindow.COUNT_STATISTICS_PIECE; ++i)
			{
				var nameOfStatistic:String = this.namesOfStatistics[i]
				if (this.isExistItemInData(nameOfStatistic))
				{
					this.updateDataInChunk(nameOfStatistic, this.statistics[nameOfStatistic]);
				}
				else
				{
					this.createAndPushChunk(nameOfStatistic, this.statistics[nameOfStatistic]);
				}
			}
		}
		
		private function isExistItemInData(nameOfStatistic:String):Boolean
		{
			var isExist:Boolean = false;
			
			for (var i:int = 0; i < this.data.length;  ++i)
			{
				if (this.data[i] != null && this.data[i].title == nameOfStatistic)
				{
					isExist = true;
					break;
				}
			}
			
			return isExist;
		}
		
		private function updateDataInChunk(nameOfStatistic:String, value:int):void
		{
			for (var i:int = 0; i < this.data.length;  ++i)
			{
				if (this.data[i] != null && this.data[i].title == nameOfStatistic)
				{
					this.data[i].updateData(value);
					break;
				}
			}
		}
		
		private function createAndPushChunk(nameOfStatistic:String, value:int):void
		{
			var newChunk:ChunkStatistics = new ChunkStatistics(nameOfStatistic, value, this.flow)
			var order:int = newChunk.order;
			
			if (order != -1)
			{
				this.putAtIndexInVector(newChunk, order);
			}
			else
			{
				this.data.push(newChunk);
			}
		}
		
		private function putAtIndexInVector(newChunk:ChunkStatistics, index:int):void
		{
			var lenght:int = this.data.length;
			
			if (lenght <= index)
			{
				for (var i:int = 0; i <= index - lenght; ++i)
					this.data.push(newChunk);
			}
			else
			{
				this.data[index] = newChunk;
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