package ui.windows 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import ui.ChaoticUI;
	
	public class AchievementsWindow extends WindowBase
	{
		
		public function AchievementsWindow(root:DisplayObjectContainer, flow:IUpdateDispatcher) 
		{
			super(350, 400)
			
			this.visible = false;
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(ChaoticUI.openWindow);
			
			root.addChild(this);
		}
		
		public function openWindow(target:String):void
		{
			if(target == ManagerWindows.ACHIEVEMENTS)
				this.visible = true;
			else
				this.visible = false;
		}
		
	}

}