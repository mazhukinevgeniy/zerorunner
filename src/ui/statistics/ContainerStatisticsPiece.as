package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.data.ListCollection;
	import feathers.dragDrop.IDragSource;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import game.statistics.StatisticsPiece;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import ui.themes.ExtendedTheme;
	
	public class ContainerStatisticsPiece extends ScrollContainer implements IDragSource
	{
		private static const INTERVAL:Number = 3;
		private static const LABEL_Y:Number = -5;
		
		private var flow:IUpdateDispatcher;
		
		private var list:List;
		private var rollButton:Button;
		private var fixButton:Button;
		
		private var label:Label;
		
		private var fullHeight:Number;
		
		public function ContainerStatisticsPiece(newItem:StatisticsPiece, flow:IUpdateDispatcher) 
		{		
			this.layout = new AnchorLayout();
			
			this.rollButton = new Button();
			this.rollButton.label = "-";
			this.rollButton.nameList.add(ExtendedTheme.BUTTON_STATISTICS_ROLL);
			this.rollButton.layoutData = this.createLayoutData();
			this.addChild(this.rollButton);
			
			this.fixButton = new Button();
			this.fixButton.nameList.add(ExtendedTheme.BUTTON_STATISTICS_FIX);
			this.fixButton.layoutData = this.createLayoutData(this.rollButton, ContainerStatisticsPiece.INTERVAL)
			this.addChild(this.fixButton);
			
			this.label = new Label();
			this.label.text = newItem.title;
			this.label.nameList.add(ExtendedTheme.TITLE_STATICTICS_PIECE);
			this.label.layoutData = this.createLayoutData(this.fixButton, ContainerStatisticsPiece.INTERVAL,
														  null, ContainerStatisticsPiece.LABEL_Y);
			this.addChild(this.label);
			
			this.list = writeInList(newItem);
			this.list.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.list.layoutData = this.createLayoutData(null, 0, this.rollButton, ContainerStatisticsPiece.INTERVAL);
			this.addChild(this.list);
			
			this.rollButton.addEventListener(Event.TRIGGERED, this.handleRollButtonTriggered);
			this.fixButton.addEventListener(Event.TRIGGERED, this.handleFixButtonTriggered);
			this.addEventListener(TouchEvent.TOUCH, this.handleContainer);
			
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
		
		private function createLayoutData(leftAnchor:DisplayObject = null, left:Number = 0,
										  topAnchor:DisplayObject = null, top:Number = 0):AnchorLayoutData
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
		
		private function handleRollButtonTriggered(event:Event):void
		{
			if (this.list.visible)
			{
				this.list.visible = false;
				this.rollButton.label = "+"
				this.fullHeight = this.height;
				this.height = this.rollButton.height;
			}
			else
			{
				this.list.visible = true;
				this.rollButton.label = "-";
				this.height = this.fullHeight;
			}
		}
		
		private function handleFixButtonTriggered():void
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
		
		private function handleContainer(event:TouchEvent):void 
		{
			var touch:Touch = event.getTouch(this, TouchPhase.MOVED)
			
			if(touch)
				this.flow.dispatchUpdate(StatisticsWindow.moveStatisticsPiece, this, touch);
			
		}
	}

}