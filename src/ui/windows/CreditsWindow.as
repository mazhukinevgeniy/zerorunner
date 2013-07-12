package ui.windows 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import ui.ChaoticUI;
	
	public class CreditsWindow extends WindowBase
	{
		
		public function CreditsWindow(root:DisplayObjectContainer, flow:IUpdateDispatcher) 
		{
			super(150, 100)
			
			this.visible = false;
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(ChaoticUI.openWindow);
			
			root.addChild(this);
		}
		
		public function openWindow(target:String):void
		{
			if(target == ManagerWindows.CREDITS)
				this.visible = true;
			else
				this.visible = false;
		}
		
	}

}