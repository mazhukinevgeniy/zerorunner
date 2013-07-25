package ui 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import feathers.controls.ScrollContainer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import game.ZeroRunner;
	import game.statistics.StatisticsFeature;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import ui.mainMenu.MainMenu;
	
	internal class WindowsController 
	{
		private static const INDENT:Number = 30;
		private static const WINDOWS_REGION_X:Number = MainMenu.WIDTH_MAIN_MENU + WindowsController.INDENT;
		private static const WINDOWS_REGION_Y:Number = WindowsController.INDENT;
		private static const WINDOWS_REGION_WIDTH:Number = Main.WIDTH - WindowsController.INDENT - WindowsController.WINDOWS_REGION_X;
		private static const WINDOWS_REGION_HEIGHT:Number = Main.HEIGHT - 2 * WindowsController.INDENT;
		
		
		private var windows:Vector.<ScrollContainer>;
		private var flow:IUpdateDispatcher;
		private var frame:ScrollContainer;
		
		public function WindowsController(root:DisplayObjectContainer, flow:IUpdateDispatcher, windows:Vector.<ScrollContainer>) 
		{
			this.windows = windows;
			this.frame = this.createRegionWindows();
			
			var windowsLayoutData:AnchorLayoutData = this.createWindowsLayoutData();
			
			for (var i:int = 0; i < this.windows.length; ++i)
			{
				if (i != WindowsFeature.MENU)
				{
					this.frame.addChild(this.windows[i]);
					this.windows[i].layoutData = windowsLayoutData;
				}
				else
					root.addChild(this.windows[i]);
			}
			
			root.addChild(this.frame);
			
			this.flow = flow;
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(ChaoticUI.openWindow);
			this.flow.addUpdateListener(ChaoticUI.newGame);
			this.flow.addUpdateListener(ZeroRunner.quitGame);
			
			
		}
		
		update function openWindow(targetId:int):void
		{
			for (var id:int = 0; id < this.windows.length; ++id)
			{
				if ((targetId == id) || id == WindowsFeature.MENU)
					this.windows[id].visible = true;
				else
					this.windows[id].visible = false;
			}
			
			if (targetId == WindowsFeature.STATISTICS)
			{
				this.flow.dispatchUpdate(StatisticsFeature.showStatistics);
			}
		}
		
		update function newGame():void
		{
			for (var id:int = 0; id < this.windows.length; ++id)
			{
				this.windows[id].visible = false;
			}
		}
		
		update function quitGame():void
		{
			for (var id:int = 0; id < this.windows.length; ++id)
			{
				if(id == WindowsFeature.MENU)
					this.windows[id].visible = true;
			}
		}
		
		private function createRegionWindows():ScrollContainer
		{
			var frame:ScrollContainer = new ScrollContainer();
			
			frame.width = WindowsController.WINDOWS_REGION_WIDTH;
			frame.height = WindowsController.WINDOWS_REGION_HEIGHT;
			frame.x = WindowsController.WINDOWS_REGION_X;
			frame.y = WindowsController.WINDOWS_REGION_Y;
			frame.layout = new AnchorLayout();
			
			return frame;
		}
		
		private function createWindowsLayoutData():AnchorLayoutData
		{
			var layoutData:AnchorLayoutData = new AnchorLayoutData();
			
			layoutData.horizontalCenter = 0;
			layoutData.verticalCenter = 0;
			
			return layoutData;
		}
	}

}