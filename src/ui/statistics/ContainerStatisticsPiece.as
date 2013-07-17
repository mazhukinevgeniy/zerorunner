package ui.statistics 
{
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;
	
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
			
		}
		
	}

}