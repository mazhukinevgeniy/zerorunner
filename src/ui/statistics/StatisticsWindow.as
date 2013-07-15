package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import ui.ChaoticUI;
	import ui.WindowBase;
	import ui.WindowsFeature;
	
	public class StatisticsWindow extends WindowBase
	{
		
		public function StatisticsWindow(flow:IUpdateDispatcher) 
		{
			super(250, 250)
			
			this.visible = false;
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(ChaoticUI.openWindow);
		}
		
		public function openWindow(target:String):void
		{
			if(target == WindowsFeature.STATISTICS)
				this.visible = true;
			else
				this.visible = false;
		}
		
	}

}