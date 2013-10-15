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
		private const structure:Object = 
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
		
		public static const COUNT_STATISTICS_PIECE:int = 1;
		public static const WIDTH_STATISTICS_WINDOW:Number = 200;
		public static const MAX_HEIGHT_STATISTICS_WINDOW:Number = 450;
		
		private static const PADDING:Number = 5;
		
		private var blocks:Vector.<ChunkStatistics>;
		
		public function StatisticsWindow(database:DatabaseManager) 
		{
			setSize();
			setBackground();
			setLayout();
			setScrollBar();
			
			this.blocks = new Vector.<ChunkStatistics>();
			
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
			
			super.visible = value;
		}
		
		private function composeView():void
		{
			/* updateData:
			for (var i:int = 0; i < StatisticsWindow.COUNT_STATISTICS_PIECE; ++i)
			{
				var nameOfStatistic:String = this.namesOfStatistics[i]
				if (this.isExistItemInData(nameOfStatistic))
				{
					this.updateDataInChunk(nameOfStatistic, this.statistics[nameOfStatistic]);
				}
				else
				{
					this.createAndPushChunk(nameOfStatistic, this.statistics[nameOfStatistic]);
				}
			}
			 */
			
			/* redraw:
			var lenght:int = this.data.length;
			
			this.removeChildren();
			
			for (var i:int = 0;  i < lenght; ++i)
			{
				this.addChild(this.data[i]);
			}
			 */
		}
		
		private function isExistItemInData(nameOfStatistic:String):Boolean
		{
			var isExist:Boolean = false;
			
			for (var i:int = 0; i < this.data.length;  ++i)
			{
				if (this.data[i] != null && this.data[i].title == nameOfStatistic)
				{
					isExist = true;
					break;
				}
			}
			
			return isExist;
		}
		
		private function updateDataInChunk(nameOfStatistic:String, value:int):void
		{
			for (var i:int = 0; i < this.data.length;  ++i)
			{
				if (this.data[i] != null && this.data[i].title == nameOfStatistic)
				{
					this.data[i].updateData(value);
					break;
				}
			}
		}
		
		private function createAndPushChunk(nameOfStatistic:String, value:int):void
		{
			var newChunk:ChunkStatistics = new ChunkStatistics(nameOfStatistic, value, this)
			
			if (order != -1)
			{
				this.putAtIndexInVector(newChunk, order);
			}
			else
			{
				this.data.push(newChunk);
			}
		}
		
		private function putAtIndexInVector(newChunk:ChunkStatistics, index:int):void
		{
			var lenght:int = this.data.length;
			
			if (lenght <= index)
			{
				for (var i:int = 0; i <= index - lenght; ++i)
					this.data.push(newChunk);
			}
			else
			{
				this.data[index] = newChunk;
			}
		}
		
		
	}

}