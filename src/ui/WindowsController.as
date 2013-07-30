package ui 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import feathers.controls.ScrollContainer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import game.ZeroRunner;
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
		
		private static const UNDETERMINED:int = -1;
		
		private var windows:Vector.<ScrollContainer>;
		private var flow:IUpdateDispatcher;
		
		private var idLastOpenedWindow:int;
		
		public function WindowsController(root:DisplayObjectContainer, flow:IUpdateDispatcher, windows:Vector.<ScrollContainer>) 
		{
			this.windows = windows;
			
			this.idLastOpenedWindow = WindowsController.UNDETERMINED;
			
			var frame:ScrollContainer = this.createRegionWindows();
			var windowsLayoutData:AnchorLayoutData = this.createWindowsLayoutData();
			var lenght:int = this.windows.length;
			
			for (var id:int = 0; id < lenght; ++id)
			{
				if (id != WindowsFeature.MENU)
				{
					this.windows[id].layoutData = windowsLayoutData;
					this.windows[id].visible = false;
					frame.addChild(this.windows[id]);
				}
				else
					root.addChild(this.windows[id]);
				
			}
			
			root.addChild(frame);
			
			this.flow = flow;
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(ChaoticUI.openWindow);
			this.flow.addUpdateListener(ChaoticUI.newGame);
			this.flow.addUpdateListener(ZeroRunner.quitGame);
			
			
		}
		
		update function openWindow(idTarget:int):void
		{
			if (idTarget != this.idLastOpenedWindow)
			{
				this.closelastOpenedWindow();
				this.windows[idTarget].visible = true;
				this.idLastOpenedWindow = idTarget;
			}
		}
		
		update function newGame():void
		{
			this.closelastOpenedWindow();
			this.windows[WindowsFeature.MENU].visible = false;
			this.idLastOpenedWindow = WindowsController.UNDETERMINED;
		}
		
		update function quitGame():void
		{
			this.windows[WindowsFeature.MENU].visible = true;
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
		
		private function closelastOpenedWindow():void
		{
			if (this.idLastOpenedWindow != WindowsController.UNDETERMINED)
				this.windows[this.idLastOpenedWindow].visible = false;
		}
	}

}