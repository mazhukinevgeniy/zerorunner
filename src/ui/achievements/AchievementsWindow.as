package ui.achievements 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import ui.ChaoticUI;
	import ui.WindowBase;
	import ui.WindowsFeature;
	
	public class AchievementsWindow extends WindowBase
	{
		
		public function AchievementsWindow(flow:IUpdateDispatcher) 
		{
			super(350, 400)
			
			this.visible = false;
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(ChaoticUI.openWindow);
		}
		
		public function openWindow(target:String):void
		{
			if(target == WindowsFeature.ACHIEVEMENTS)
				this.visible = true;
			else
				this.visible = false;
		}
		
	}

}