package game.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import game.ZeroRunner;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class StatisticsView implements ITakeStatistics
	{
		private var container:Sprite;
		private var list:List;
		
		private var flow:IUpdateDispatcher;
		
		
		private var entries:Vector.<Object>;
		
		public function StatisticsView(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(StatisticsFeature.showStatistics);
			flow.addUpdateListener(StatisticsFeature.hideStatistics);
			flow.addUpdateListener(ZeroRunner.quitGame);
			
			this.container = new Sprite();
			flow.dispatchUpdate(ZeroRunner.addToTheHUD, this.container);
			
			this.container.x = 50;
			this.container.y = 50;
			
			this.container.addChild(new Quad(100, 200, 0xFFFFFF));
			
			this.container.addChild(this.list = new List());
			this.list.itemRendererProperties.labelField = "text";
			
			this.container.visible = false;
		}
		
		update function showStatistics():void
		{
			this.container.visible = true;
			
			this.entries = new Vector.<Object>();
			
			this.flow.dispatchUpdate(StatisticsFeature.emitStatistics, this);
			
			this.list.dataProvider = new ListCollection(this.entries);
		}
		
		update function hideStatistics():void
		{
			this.container.visible = false;
			
			this.entries = null;
		}
		
		update function quitGame():void
		{
			if (this.container.visible)
				this.update::hideStatistics();
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