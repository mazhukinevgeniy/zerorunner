package ui 
{
	import feathers.controls.ScrollContainer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import starling.display.DisplayObjectContainer;
	import ui.mainMenu.MainMenu;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class WindowsController 
	{
		private static const UNDETERMINED:int = -1;
		
		private var windows:Vector.<ScrollContainer>;
		private var flow:IUpdateDispatcher;
		
		private var idLastOpenedWindow:int;
		
		public function WindowsController(root:DisplayObjectContainer, flow:IUpdateDispatcher, windows:Vector.<ScrollContainer>) 
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
			this.flow.addUpdateListener(Update.newGame);
			this.flow.addUpdateListener(Update.quitGame);
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
		
		private function closelastOpenedWindow():void
		{
			if (this.idLastOpenedWindow != WindowsController.UNDETERMINED)
				this.windows[this.idLastOpenedWindow].visible = false;
		}
		
		update function quitGame():void
		{
			this.windows[WindowsFeature.MENU].visible = true;
		}
		
		
	}

}