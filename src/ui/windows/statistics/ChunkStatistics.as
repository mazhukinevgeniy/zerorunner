package ui.windows.statistics 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.data.ListCollection;
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.DragDropManager;
	import feathers.dragDrop.IDragSource;
	import feathers.events.DragDropEvent;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import statistics.StatisticsPiece;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;
	
	public class ChunkStatistics extends ScrollContainer implements IDragSource
	{
		public static const CHUNK_STATISTICS_DRAG_FORMAT:String = "chunk-statistics-drag-format"
		
		private static const GAP:Number = 3;
		private static const BUTTON_PADDING_TOP:Number = 5;
		
		private var flow:IUpdateDispatcher;
		
		private var list:List;
		private var rollButton:Button;
		private var fixButton:Button;
		private var label:Label;
		
		private var fullHeight:Number;
		private var rollHeight:Number;
		
		private var isDragging:Boolean;
		private var isRoll:Boolean;
		
		private var saveForm:FormChunkStatistics;
		private var firstReadSave:Boolean;
		
		
		public function ChunkStatistics(newData:StatisticsPiece, flow:IUpdateDispatcher) 
		{		
			this.initializeRollButton();
			this.initializeFixButton();
			this.initializeTitle(newData.title);
			this.initializeList(newData);
			this.initializeOtherFields(flow);
			
			this.initializeEventListeners();
		}
		
		private function initializeRollButton():void
		{
			this.rollButton = new Button();
			this.rollButton.nameList.add(ExtendedTheme.BUTTON_STATISTICS_ROLL);
			this.rollButton.layoutData = this.createLayoutData(null, ChunkStatistics.BUTTON_PADDING_TOP);
			this.addChild(this.rollButton);
			
			this.rollButton.addEventListener(Event.TRIGGERED, this.handleRollButtonTriggered);
		}
		
		private function handleRollButtonTriggered(event:Event = null):void
		{
			if (!this.isRoll)
			{
				this.makeListInvisible();
			}
			else
			{
				this.makeListVisible();
			}
			
			this.saveForm.isRoll = this.isRoll;
		}

		private function makeListInvisible():void
		{
			this.list.visible = false;
			this.isRoll = true;
			this.fullHeight = this.height;
			this.height = this.rollHeight;
		}
		
		private function makeListVisible():void
		{
			this.list.visible = true;
			this.isRoll = false;
			this.height = this.fullHeight;
		}
		
		private function initializeFixButton():void
		{
			this.fixButton = new Button();
			this.fixButton.nameList.add(ExtendedTheme.BUTTON_STATISTICS_FIX);
			this.fixButton.layoutData = this.createLayoutData(null, ChunkStatistics.BUTTON_PADDING_TOP, this.rollButton, ChunkStatistics.GAP)
			this.addChild(this.fixButton);
			
			this.fixButton.addEventListener(Event.TRIGGERED, this.handleFixButtonTriggered);
		}
		
		private function handleFixButtonTriggered(event:Event = null):void
		{
			if (this.rollButton.isEnabled)
			{
				this.rollButton.isEnabled = false;
			}
			else
			{
				this.rollButton.isEnabled = true;
			}
			
			this.saveForm.isFix = !this.rollButton.isEnabled
		}
		
		private function initializeTitle(newTitle:String):void
		{
			this.label = new Label();
			this.label.text = newTitle;
			this.label.nameList.add(ExtendedTheme.TITLE_STATICTICS_PIECE);
			this.label.layoutData = this.createLayoutData(null, 0, this.fixButton, ChunkStatistics.GAP)
			this.addChild(this.label);
			
			this.label.addEventListener(Event.ADDED, this.changeForm);
		}
		
		private function changeForm(event:Event):void
		{
			if (this.firstReadSave && this.label.height != 0)
			{
				this.rollHeight = this.label.height;
				
				if (this.saveForm.isRoll)
				{
					this.handleRollButtonTriggered();
				}
				
				if (this.saveForm.isFix)
				{
					this.handleFixButtonTriggered();
				}
				
				this.firstReadSave = false;
			}
		}
		
		private function initializeList(newData:StatisticsPiece):void
		{
			this.list = writeInList(newData);
			this.list.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.list.layoutData = this.createLayoutData(this.label, ChunkStatistics.GAP);
			this.addChild(this.list);
		}
		
		private function writeInList(newData:StatisticsPiece):List
		{
			var list:List = new List();
			var data:Vector.<Object> = new Vector.<Object>;
			
			list.dataProvider = new ListCollection(data);
			
			for (var i:int = 0; i < newData.length; ++i)
			{
				var string:String = newData.entry[i];
				data.push(string);
			}
			
			return list;
		}
		
		private function createLayoutData(topAnchor:DisplayObject = null, top:Number = 0,
										  leftAnchor:DisplayObject = null, left:Number = 0):AnchorLayoutData
		{
			var layoutData:AnchorLayoutData = new AnchorLayoutData();
			if(leftAnchor != null)
				layoutData.leftAnchorDisplayObject = leftAnchor;
				
			if (topAnchor != null)
				layoutData.topAnchorDisplayObject = topAnchor;

			layoutData.left = left;
			layoutData.top = top;
			
			return layoutData;
		}
		
		private function initializeOtherFields(flow:IUpdateDispatcher):void
		{
			this.layout = new AnchorLayout();
			
			this.isRoll = false;
			this.isDragging = false;
			
			this.saveForm = new FormChunkStatistics(this.title);
			this.firstReadSave = true;
			
			this.flow = flow;
		}
		
		private function initializeEventListeners():void
		{
			this.addEventListener(TouchEvent.TOUCH, this.handleContainerTouch);
			this.addEventListener(DragDropEvent.DRAG_COMPLETE, this.dropComplete);
		}
		
		private function handleContainerTouch(event:TouchEvent):void 
		{
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED)
			
			if (touchMoved && event.target != this.rollButton && event.target != this.fixButton)
			{
				
				if (!this.isDragging)
				{
					this.startDrag(touchMoved);
				}
			}	
		}
		
		private function startDrag(touch:Touch):void
		{
			var dragData:DragData = new DragData();
			
			dragData.setDataForFormat(ChunkStatistics.CHUNK_STATISTICS_DRAG_FORMAT, this);
			DragDropManager.startDrag(this, touch, dragData, this);
			this.isDragging = true;
		}
		
		private function dropComplete(event:DragDropEvent, dragData:DragData):void
		{
			this.isDragging = false;
			if (!event.isDropped) 
			{
				this.processDropMiss();
			}
		}
		
		private function processDropMiss():void
		{
			if (!this.isRoll) 
				this.handleRollButtonTriggered();
			this.flow.dispatchUpdate(StatisticsWindow.dropMiss);
		}
		
		public function get title():String
		{
			return this.label.text;
		}
		
		public function get order():int
		{
			return this.saveForm.order;
		}
		
		public function set order(newOrder:int):void
		{
			this.saveForm.order = newOrder;
		}
		
		public function updateData(newItem:StatisticsPiece):void
		{
			var newList:List = this.writeInList(newItem);
			this.list.dataProvider = newList.dataProvider;
		}
		
	}

}