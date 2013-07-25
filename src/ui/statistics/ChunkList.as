package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
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
	import game.statistics.StatisticsPiece;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import ui.themes.ExtendedTheme;
	
	public class ChunkList extends ScrollContainer implements IDragSource
	{
		private static const GAP:Number = 3;
		private static const BUTTON_PADDING_TOP:Number = 5;
		
		private var flow:IUpdateDispatcher;
		
		private var list:List;
		private var rollButton:Button;
		private var fixButton:Button;
		
		private var label:Label;
		
		private var fullHeight:Number;
		
		private var isDragging:Boolean;
		private var isRoll:Boolean;
		
		public function ChunkList(newItem:StatisticsPiece, flow:IUpdateDispatcher) 
		{		
			this.layout = new AnchorLayout();
			
			this.rollButton = new Button();
			this.rollButton.nameList.add(ExtendedTheme.BUTTON_STATISTICS_ROLL);
			this.rollButton.layoutData = this.createLayoutData(null, ChunkList.BUTTON_PADDING_TOP);
			this.addChild(this.rollButton);
			
			
			this.fixButton = new Button();
			this.fixButton.nameList.add(ExtendedTheme.BUTTON_STATISTICS_FIX);
			this.fixButton.layoutData = this.createLayoutData(null, ChunkList.BUTTON_PADDING_TOP, this.rollButton, ChunkList.GAP)
			this.addChild(this.fixButton);
			
			this.label = new Label();
			this.label.text = newItem.title;
			this.label.nameList.add(ExtendedTheme.TITLE_STATICTICS_PIECE);
			this.label.layoutData = this.createLayoutData(null, 0, this.fixButton, ChunkList.GAP)
			this.addChild(this.label);
			
			this.list = writeInList(newItem);
			this.list.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.list.layoutData = this.createLayoutData(this.label, ChunkList.GAP);
			this.addChild(this.list);
			this.isRoll = false;
			
			this.rollButton.addEventListener(Event.TRIGGERED, this.handleRollButtonTriggered);
			this.fixButton.addEventListener(Event.TRIGGERED, this.handleFixButtonTriggered);
			
			this.addEventListener(TouchEvent.TOUCH, this.handleContainerTouch);
			this.addEventListener(DragDropEvent.DRAG_COMPLETE, this.dropComplete);
			
			this.isDragging = false;
			
			this.flow = flow;
			
		}
		
		public function get title():String
		{
			return this.label.text;
		}
		
		public function updateData(newItem:StatisticsPiece):void
		{
			var newList:List = this.writeInList(newItem);
			this.list.dataProvider = newList.dataProvider;
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
		
		private function writeInList(newItem:StatisticsPiece):List
		{
			var list:List = new List();
			var data:Vector.<Object> = new Vector.<Object>;
			
			list.dataProvider = new ListCollection(data);
			list.itemRendererProperties.labelField = "text";
			
			for (var i:int = 0; i < newItem.length; ++i)
			{
				var string:String = newItem.entry[i];
				data.push(string);
			}
			
			return list;
		}
		
		private function handleRollButtonTriggered(event:Event = null):void
		{
			if (!this.isRoll)
			{
				this.removeChild(this.list);
				this.isRoll = true;
				this.fullHeight = this.height;
				this.height = this.label.height;
			}
			else
			{
				this.addChild(this.list);
				this.isRoll = false;
				this.height = this.fullHeight;
			}
		}
		
		private function handleFixButtonTriggered(event:Event):void
		{
			if (this.rollButton.isEnabled)
			{
				this.rollButton.isEnabled = false;
			}
			else
			{
				this.rollButton.isEnabled = true;
			}
		}
		
		private function handleContainerTouch(event:TouchEvent):void 
		{
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED)
			
			if (touchMoved)
			{
				var dragData:DragData = new DragData();
				dragData.setDataForFormat("display-object-drag-format", this);
				if (!this.isDragging)
				{
					DragDropManager.startDrag(this, touchMoved, dragData, this);
					this.isDragging = true;
				}
			}
			
		}
		
		private function dropComplete(event:DragDropEvent, dragData:DragData):void
		{
			this.isDragging = false;
			if (!event.isDropped) 
			{
				if (!this.isRoll) 
					this.handleRollButtonTriggered();
				this.flow.dispatchUpdate(StatisticsWindow.dropMiss);
			}
		}
		
	}

}