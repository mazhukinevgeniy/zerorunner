package ui.statistics 
{
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;
	import starling.events.Event;
	
	public class ContainerStatisticsPiece extends ScrollContainer
	{
		
		private var list:List;
		private var rollBatton:Button;
		
		public function ContainerStatisticsPiece(list:List) 
		{
			this.layout = new VerticalLayout();
			
			this.rollBatton = new Button();
			this.rollBatton.label = "-";
			this.rollBatton.width = 15;
			this.rollBatton.height = 15;
			this.addChild(this.rollBatton);
			
			this.list = list;
			this.addChild(this.list);
			
			this.rollBatton.addEventListener(Event.TRIGGERED, this.handleRollButtonTriggered)
			
		}
		
		private function handleRollButtonTriggered(event:Event):void
		{
			if (this.list.visible == true)
			{
				this.list.visible = false;
				this.rollBatton.label = "+"
			}
			else
			{
				this.list.visible = true;
				this.rollBatton.label = "-"
			}
		}
		
	}

}