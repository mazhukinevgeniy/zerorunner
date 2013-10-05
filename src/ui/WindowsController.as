package ui 
{
	import feathers.controls.ScrollContainer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class WindowsController 
	{
		private static const UNDETERMINED:int = -1;
		
		private var windows:Vector.<DisplayObject>;
		private var flow:IUpdateDispatcher;
		
		private var idLastOpenedWindow:int;
		
		public function WindowsController(flow:IUpdateDispatcher, windows:Vector.<DisplayObject>) 
		{
			this.windows = windows;
			
			this.idLastOpenedWindow = WindowsController.UNDETERMINED;
			
			this.initializationUsingFlow(flow);
		}
		
		private function initializationUsingFlow(flow:IUpdateDispatcher):void
		{
			this.flow = flow;
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.openWindow);
		}
		
		update function openWindow(idTarget:int):void
		{//TODO: rename: open -> toggle
			this.closelastOpenedWindow();
			
			if (idTarget != this.idLastOpenedWindow)
			{
				this.windows[idTarget].visible = true;
				this.idLastOpenedWindow = idTarget;
				
				if (idTarget == Windows.GAME)
					this.flow.dispatchUpdate(Update.newGame);
			}
			else
			{
				this.idLastOpenedWindow = WindowsController.UNDETERMINED;
			}
		}
		
		private function closelastOpenedWindow():void
		{
			if (this.idLastOpenedWindow != WindowsController.UNDETERMINED)
				this.windows[this.idLastOpenedWindow].visible = false;
		}		
	}

}