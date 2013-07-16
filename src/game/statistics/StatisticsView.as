package game.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import game.ZeroRunner;
	import starling.display.Sprite;
	
	public class StatisticsView 
	{
		private var container:Sprite;
		private var list:List;
		
		private var flow:IUpdateDispatcher;
		
		
		private var entries:Vector.<Object>;
		
		public function StatisticsView(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
			flow.dispatchUpdate(ZeroRunner.addToTheHUD, this.container);
			
			this.container = new Sprite();
			
			this.container.addChild(this.list = new List());
			this.list.itemRendererProperties.labelField = "text";
		}
		
		public function ~~~showStatistics():void
		{
			this.container.visible = true;
			
			this.entries = new Vector.<Object>();
			
			this.flow.dispathUpdate(StatisticsFeature.emitStatistics);
			
			this.list.dataProvider = new ListCollection(this.entries);
		}
		
		public function takeStatistics(piece:StatisticsPiece):void
		{
			for (var i:int = 0; i < piece.length; i++)
			{
				this.addEntry(piece.entry[i]);
			}
		}
		
		private function addEntry(string:String):void
		{
			this.entries.push( { text: string } );
		}
	}

}