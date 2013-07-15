package ui.credits 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import ui.ChaoticUI;
	import ui.WindowBase;
	import ui.WindowsFeature;
	
	public class CreditsWindow extends WindowBase
	{
		
		public function CreditsWindow(flow:IUpdateDispatcher) 
		{
			super(150, 100)
			
			this.visible = false;
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(ChaoticUI.openWindow);
		}
		
		public function openWindow(target:String):void
		{
			if(target == WindowsFeature.CREDITS)
				this.visible = true;
			else
				this.visible = false;
		}
		
	}

}