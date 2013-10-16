package ui.windows.statistics 
{
	import data.DatabaseManager;
	import data.structs.StatisticsInfo;
	import feathers.controls.IScrollBar;
	import feathers.controls.ScrollBar;
	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;
	import starling.display.Quad;
	import starling.events.Event;
	import ui.navigation.Menu;
	import utils.updates.update;

	
	public class StatisticsWindow  extends ScrollContainer
	{
		public static const WIDTH_STATISTICS_WINDOW:Number = 200;
		public static const MAX_HEIGHT_STATISTICS_WINDOW:Number = 450;
		
		private static const PADDING:Number = 5;
		
		
		private var data:DatabaseManager;
		
		public function StatisticsWindow(database:DatabaseManager) 
		{
			this.data = database;
			
			this.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW + 2 * StatisticsWindow.PADDING;
			this.maxHeight = StatisticsWindow.MAX_HEIGHT_STATISTICS_WINDOW;
			
			
			this.setBackground();
			this.setLayout();
			this.setScrollBar();
			
			
			this.x = (Main.WIDTH - this.width) / 2;
			this.y = (Main.HEIGHT - this.height) / 4;
			//TODO: "this.height" is much greater than this height, so normal calculation results in ugly looks;
			//      it'll work for now, but someday we'll need to resolve or discard this issue
		}
		
		private function setBackground():void
		{
			var tmp:Quad = new Quad(StatisticsWindow.WIDTH_STATISTICS_WINDOW, 1, 0xFFFFFF);
			
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
		}
		
		private function setLayout():void
		{
			var layout:VerticalLayout = new VerticalLayout();
			
			layout.gap = StatisticsWindow.PADDING;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			this.padding = StatisticsWindow.PADDING;
			this.layout = layout;
		}
		
		private function setScrollBar():void 
		{
			this.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;
			this.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_AUTO;
			this.interactionMode = ScrollContainer.INTERACTION_MODE_MOUSE;
			
			this.verticalScrollBarFactory = function():IScrollBar
			{
				var newScrollBar:ScrollBar = new ScrollBar();
				newScrollBar.direction = ScrollBar.DIRECTION_VERTICAL;
				
				return newScrollBar; 
			}
		}
		
		override public function set visible(value:Boolean):void
		{
			if (value)
			{
				this.composeView();
			}
			else
			{
				this.removeChildren();
				//TODO: make sure there's no memory leak
			}
			
			super.visible = value;
		}
		
		private function composeView():void
		{
			var chunk:ChunkStatistics;
			var info:StatisticsInfo = (this.data).statistics;
			
			
			chunk = new ChunkStatistics("global", composeGlobalStat(info));
			this.addChild(chunk);
			
			chunk = new ChunkStatistics("test", new <String>["huh", "test"]);
			this.addChild(chunk);
			
			
			function composeGlobalStat(info:StatisticsInfo):Vector.<String>
			{
				var vect:Vector.<String> = new Vector.<String>();
				
				vect.push("distance: " + String(info.totalDistance));
				vect.push("test-test-test");
				
				return vect;
			}
		}
		
	}

}