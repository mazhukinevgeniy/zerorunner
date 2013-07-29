package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
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
	
	public class ChunkStatistics extends ScrollContainer implements ITakeSaveForm, IDragSource
	{
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
		
		private var saveRoll:Boolean;
		private var saveFix:Boolean;
		private var saveOrder:int;
		
		
		public function ChunkStatistics(newItem:StatisticsPiece, flow:IUpdateDispatcher) 
		{		
			this.layout = new AnchorLayout();
			
			this.rollButton = new Button();
			this.rollButton.nameList.add(ExtendedTheme.BUTTON_STATISTICS_ROLL);
			this.rollButton.layoutData = this.createLayoutData(null, ChunkStatistics.BUTTON_PADDING_TOP);
			this.addChild(this.rollButton);
			
			
			this.fixButton = new Button();
			this.fixButton.nameList.add(ExtendedTheme.BUTTON_STATISTICS_FIX);
			this.fixButton.layoutData = this.createLayoutData(null, ChunkStatistics.BUTTON_PADDING_TOP, this.rollButton, ChunkStatistics.GAP)
			this.addChild(this.fixButton);
			
			this.label = new Label();
			this.label.text = newItem.title;
			this.label.nameList.add(ExtendedTheme.TITLE_STATICTICS_PIECE);
			this.label.layoutData = this.createLayoutData(null, 0, this.fixButton, ChunkStatistics.GAP)
			this.addChild(this.label);
			
			this.list = writeInList(newItem);
			this.list.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.list.layoutData = this.createLayoutData(this.label, ChunkStatistics.GAP);
			this.addChild(this.list);
			this.isRoll = false;
			
			this.rollButton.addEventListener(Event.TRIGGERED, this.handleRollButtonTriggered);
			this.fixButton.addEventListener(Event.TRIGGERED, this.handleFixButtonTriggered);
			
			this.label.addEventListener(Event.ADDED, this.changeForm);
			this.addEventListener(TouchEvent.TOUCH, this.handleContainerTouch);
			this.addEventListener(DragDropEvent.DRAG_COMPLETE, this.dropComplete);
			
			this.isDragging = false;
			
			this.flow = flow;
			
			new FormChunkStatistics(this, this.flow);
		}
		
		public function get title():String
		{
			return this.label.text;
		}
		
		public function get order():int
		{
			return this.saveOrder;
		}
		
		public function set order(newOrder:int):void
		{
			this.flow.dispatchUpdate(FormChunkStatistics.changeOrder, newOrder, this.title);
		}
		
		public function updateData(newItem:StatisticsPiece):void
		{
			var newList:List = this.writeInList(newItem);
			this.list.dataProvider = newList.dataProvider;
		}
		
		public function takeSave(order:int, roll:Boolean, fix:Boolean):void
		{
			this.saveOrder = order;
			this.saveRoll = roll;
			this.saveFix = fix;
		}
		
		private function changeForm(event:Event):void
		{
			if (this.label.height != 0)
			{
				this.rollHeight = this.label.height;
				
				if (this.saveRoll)
					this.handleRollButtonTriggered();
				
				if (this.saveFix)
					this.handleFixButtonTriggered();
			}
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
				this.list.visible = false;
				this.isRoll = true;
				this.fullHeight = this.height;
				this.height = this.rollHeight;
			}
			else
			{
				this.list.visible = true;
				this.isRoll = false;
				this.height = this.fullHeight;
			}
			
			this.flow.dispatchUpdate(FormChunkStatistics.toggleRoll, this.isRoll, this.title);
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
			
			this.flow.dispatchUpdate(FormChunkStatistics.toggleFix, !this.rollButton.isEnabled, this.title);
		}
		
		private function handleContainerTouch(event:TouchEvent):void 
		{
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED)
			
			if (touchMoved && event.target != this.rollButton && event.target != this.fixButton)
			{
				
				if (!this.isDragging)
				{
					var dragData:DragData = new DragData();
					dragData.setDataForFormat("display-object-drag-format", this);
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