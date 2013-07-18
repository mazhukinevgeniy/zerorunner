package ui.statistics 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.data.ListCollection;
	import game.statistics.StatisticsPiece;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	
	public class ContainerStatisticsPiece extends ScrollContainer
	{
		private static const SIZE_ROLL_BUTTON:Number = 15;
		private static const INTERVAL:Number = 3;
		private static const LABEL_Y:Number = -5;
		
		private var list:List;
		private var rollButton:Button;
		private var fixButton:Button;
		
		private var label:Label;
		
		private var fullHeight:Number;
		
		public function ContainerStatisticsPiece(newItem:StatisticsPiece) 
		{			
			this.rollButton = new Button();
			this.rollButton.label = "-";
			this.rollButton.width = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			this.rollButton.height = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			this.addChild(this.rollButton);
			
			this.fixButton = new Button();
			this.fixButton.width = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			this.fixButton.height = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			this.fixButton.x = ContainerStatisticsPiece.SIZE_ROLL_BUTTON + ContainerStatisticsPiece.INTERVAL;
			this.addChild(this.fixButton);
			
			this.label = new Label();
			this.label.text = newItem.title;
			this.label.x = 2 * ContainerStatisticsPiece.SIZE_ROLL_BUTTON + ContainerStatisticsPiece.INTERVAL;
			this.label.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW - this.label.x;
			this.label.y = ContainerStatisticsPiece.LABEL_Y;
			this.label.nameList.add(ExtendedTheme.TITLE_STATICTICS_PIECE);
			this.addChild(this.label);
			
			this.list = writeInList(newItem);
			this.list.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.list.y = ContainerStatisticsPiece.SIZE_ROLL_BUTTON + ContainerStatisticsPiece.INTERVAL;
			this.addChild(this.list);
			
			this.rollButton.addEventListener(Event.TRIGGERED, this.handleRollButtonTriggered)
			this.fixButton.addEventListener(Event.TRIGGERED, this.handleFixButtonTriggered)
			
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
				this.height = this.label.height;
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
	}

}