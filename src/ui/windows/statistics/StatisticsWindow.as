package ui.windows.statistics 
{
	import data.DatabaseManager;
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
		
		public function StatisticsWindow(database:DatabaseManager) 
		{
			setSize();
			setBackground();
			setLayout();
			setScrollBar();
			
			//TODO: check if required:
			/*
			this.x = (Main.WIDTH + Menu.WIDTH_MENU - this.width) / 2;
			this.y = (Main.HEIGHT - this.height) / 2;
			*/
			
			function setSize():void
			{
				this.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW + 2 * StatisticsWindow.PADDING;
				this.maxHeight = StatisticsWindow.MAX_HEIGHT_STATISTICS_WINDOW;
				
				this.lastHeight = 0;
			}
			
			function setBackground():void
			{
				var tmp:Quad = new Quad(StatisticsWindow.WIDTH_STATISTICS_WINDOW, 1, 0xFFFFFF);
				
				tmp.alpha = 0.85;
				this.backgroundSkin = tmp;
			}
			
			function setLayout():void
			{
				var layout:VerticalLayout = new VerticalLayout();
				
				layout.gap = StatisticsWindow.PADDING;
				layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
				this.padding = StatisticsWindow.PADDING;
				this.layout = layout;
			}
			
			function setScrollBar():void 
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
			}
			
			super.visible = value;
		}
		
		private function composeView():void
		{
			const structure:Object = 
			{
				global:
				{
					distance: "distance" //TODO: find the good syntax
				},
				
				alsotest:
				{
					huh: "huh",
					test: "test"
				}
			};
			
			var chunk:ChunkStatistics;
			
			/**
			 * Global statistics
			 */
			
			chunk = new ChunkStatistics("distance");
			this.addChild(chunk);
			
			/**
			 * Also (just for test)
			 */
			
			chunk = new ChunkStatistics("test");
			this.addChild(chunk);
		}
		
	}

}