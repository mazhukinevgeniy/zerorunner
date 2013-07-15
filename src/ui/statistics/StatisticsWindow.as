package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import ui.ChaoticUI;
	import ui.WindowsFeature;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class StatisticsWindow  extends Sprite
	{	
		private var flow:IUpdateDispatcher;
		
		public function StatisticsWindow(flow:IUpdateDispatcher, name:String = "StatisticsWindow") 
		{
			this.name =  WindowsFeature.STATISTICS;
			
			var tmp:Quad = new Quad(250, 250, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
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