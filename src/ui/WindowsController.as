package ui 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author 
	 */
	internal class WindowsController 
	{
		
		private var windows:Vector.<DisplayObject>;
		
		public function WindowsController(root:DisplayObjectContainer, flow:IUpdateDispatcher, windows:Vector.<DisplayObject>) 
		{
			this.windows = windows;
			
			for (var i:int = 0; i < this.windows.length; ++i)
			{
				root.addChild(this.windows[i]);
				if (!(this.windows[i].name == WindowsFeature.MENU))
					this.centerAlignment(this.windows[i]);
			}
		}
		
		private function centerAlignment(movingWindow:DisplayObject):void
		{
			movingWindow.x = (WindowsFeature.WINDOWS_REGION_WIDTH - movingWindow.width) / 2 + WindowsFeature.WINDOWS_REGION_X;
			movingWindow.y = (Main.HEIGHT - movingWindow.height) / 2;
		}
	}

}