package ui.achievements 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import ui.ChaoticUI;
	import ui.WindowsFeature;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class AchievementsWindow  extends Sprite
	{	
		private var flow:IUpdateDispatcher;
		
		public function AchievementsWindow(flow:IUpdateDispatcher, name:String = "AchievementsWindow") 
		{
			this.name = WindowsFeature.ACHIEVEMENTS;
			
			var tmp:Quad = new Quad(350, 400, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
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