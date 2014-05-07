package view 
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
			
			this.initializeUsingFlow(flow);
		}
		
		private function initializeUsingFlow(flow:IUpdateDispatcher):void
		{
			this.flow = flow;
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.toggleWindow);
			this.flow.addUpdateListener(Update.quitGame);
		}
		
		update function toggleWindow(idTarget:int):void
		{
			this.closelastOpenedWindow();
			
			if (idTarget != this.idLastOpenedWindow)
			{
				this.windows[idTarget].visible = true;
				this.idLastOpenedWindow = idTarget;
			}
			else
			{
				this.idLastOpenedWindow = WindowsController.UNDETERMINED;
			}
		}
		
		update function quitGame():void
		{
			this.windows[Windows.GAME].visible = false;
			
			this.idLastOpenedWindow = WindowsController.UNDETERMINED;
		}
		
		private function closelastOpenedWindow():void
		{
			if (this.idLastOpenedWindow != WindowsController.UNDETERMINED)
				this.windows[this.idLastOpenedWindow].visible = false;
		}		
	}

}