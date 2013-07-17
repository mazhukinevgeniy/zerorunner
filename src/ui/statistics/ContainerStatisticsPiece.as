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
		
		private var list:List;
		private var rollBatton:Button;
		private var fullHeight:Number;
		
		public function ContainerStatisticsPiece(list:List) 
		{
			this.layout = new VerticalLayout();
			
			this.rollBatton = new Button();
			this.rollBatton.label = "-";
			this.rollBatton.width = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			this.rollBatton.height = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			this.addChild(this.rollBatton);
			
			this.list = list;
			this.list.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.addChild(this.list);
			
			this.rollBatton.addEventListener(Event.TRIGGERED, this.handleRollButtonTriggered)
			
		}
		
		private function handleRollButtonTriggered(event:Event):void
		{
			if (this.list.visible == true)
			{
				this.list.visible = false;
				this.rollBatton.label = "+"
				this.fullHeight = this.height;
				this.height = ContainerStatisticsPiece.SIZE_ROLL_BUTTON;
			}
			else
			{
				this.list.visible = true;
				this.rollBatton.label = "-";
				this.height = this.fullHeight;
			}
		}
			}

}