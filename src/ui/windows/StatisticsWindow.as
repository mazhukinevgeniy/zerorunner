package ui.windows 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import ui.ChaoticUI;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class StatisticsWindow extends WindowBase
	{
		
		private var flow:IUpdateDispatcher;
		
		public function StatisticsWindow(root:DisplayObjectContainer, flow:IUpdateDispatcher) 
		{
			super(250, 250)
			
			this.x = (ManagerWindows.WIDTH - this.width) / 2 + ManagerWindows.X;
			this.y = (Main.HEIGHT - this.height) / 2;
			
			this.flow = flow;
			this.visible = false;
			
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