package ui.statistics 
{
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;
	import starling.events.Event;
	
	public class ContainerStatisticsPiece extends ScrollContainer
	{
		private static const SIZE_ROLL_BUTTON:Number = 15;
		private static const INTERVAL:Number = 3;
		
		private var list:List;
		private var rollButton:Button;
		private var fixButton:Button;
		
		private var fullHeight:Number;
		
		public function ContainerStatisticsPiece(list:List) 
		{			
			this.rollButton = new Button();
			this.rollButton.label = "-";
			this.rollButton.width = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			this.rollButton.height = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			this.addChild(rollButton);
			
			this.fixButton = new Button();
			this.fixButton.width = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			this.fixButton.height = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			this.fixButton.x = ContainerStatisticsPiece.SIZE_ROLL_BUTTON +  + ContainerStatisticsPiece.INTERVAL;
			this.addChild(this.fixButton);
			
			this.list = list;
			this.list.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.list.y = ContainerStatisticsPiece.SIZE_ROLL_BUTTON + ContainerStatisticsPiece.INTERVAL;
			this.addChild(this.list);
			
			this.rollButton.addEventListener(Event.TRIGGERED, this.handleRollButtonTriggered)
			this.fixButton.addEventListener(Event.TRIGGERED, this.handleFixButtonTriggered)
			
		}
		
		private function handleRollButtonTriggered(event:Event):void
		{
			if (this.list.visible)
			{
				this.list.visible = false;
				this.rollButton.label = "+"
				this.fullHeight = this.height;
				this.height = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
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