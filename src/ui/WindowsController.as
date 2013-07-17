package ui 
{
	import chaotic.core.IUpdateDispatcher;
	import game.ZeroRunner;
	import game.statistics.StatisticsFeature;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	internal class WindowsController 
	{
		
		private var windows:Vector.<DisplayObject>;
		private var flow:IUpdateDispatcher;
		
		public function WindowsController(root:DisplayObjectContainer, flow:IUpdateDispatcher, windows:Vector.<DisplayObject>) 
		{
			this.windows = windows;
			
			for (var i:int = 0; i < this.windows.length; ++i)
			{
				root.addChild(this.windows[i]);
				if (!(this.windows[i].name == WindowsFeature.MENU))
					this.centerAlignment(this.windows[i]);
			}
			
			this.flow = flow;
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(ChaoticUI.openWindow);
			this.flow.addUpdateListener(ChaoticUI.newGame);
			this.flow.addUpdateListener(ZeroRunner.quitGame);
			
			
		}
		
		private function centerAlignment(movingWindow:DisplayObject):void
		{
			movingWindow.x = (WindowsFeature.WINDOWS_REGION_WIDTH - movingWindow.width) / 2 + WindowsFeature.WINDOWS_REGION_X;
			movingWindow.y = (Main.HEIGHT - movingWindow.height) / 2;
		}
		
		public function openWindow(target:String):void
		{
			for (var i:int = 0; i < this.windows.length; ++i)
			{
				if ((target == this.windows[i].name) || this.windows[i].name == WindowsFeature.MENU)
					this.windows[i].visible = true;
				else
					this.windows[i].visible = false;
			}
			
			if (target == WindowsFeature.STATISTICS)
			{
				this.flow.dispatchUpdate(StatisticsFeature.showStatistics);
			}
		}
		
		public function  newGame():void
		{
			for (var i:int = 0; i < this.windows.length; ++i)
			{
				this.windows[i].visible = false;
			}
		}
		
		public function quitGame():void
		{
			for (var i:int = 0; i < this.windows.length; ++i)
			{
				if(this.windows[i].name == WindowsFeature.MENU)
					this.windows[i].visible = true;
			}
		}
	}

}