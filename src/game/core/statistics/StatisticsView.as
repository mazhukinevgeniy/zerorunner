package game.core.statistics 
{
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import starling.display.Quad;
	import starling.display.Sprite;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
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
			flow.addUpdateListener(Update.showStatistics);
			flow.addUpdateListener(Update.hideStatistics);
			flow.addUpdateListener(Update.quitGame);
			
			this.container = new Sprite();
			flow.dispatchUpdate(Update.addToTheHUD, this.container);
			
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
			
			this.flow.dispatchUpdate(Update.emitStatistics, this);
			
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