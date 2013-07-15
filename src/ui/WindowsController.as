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
			}
		}
	}

}