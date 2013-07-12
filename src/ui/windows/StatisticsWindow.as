package ui.windows 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import ui.ChaoticUI;
	
	public class StatisticsWindow extends WindowBase
	{
		
		public function StatisticsWindow(root:DisplayObjectContainer, flow:IUpdateDispatcher) 
		{
			super(250, 250)
			
			this.visible = false;
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(ChaoticUI.openWindow);
			
			root.addChild(this);
		}
		
		public function openWindow(target:String):void
		{
			if(target == ManagerWindows.STATISTICS)
				this.visible = true;
			else
				this.visible = false;
		}
		
	}

}