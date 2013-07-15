package ui.credits 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import ui.ChaoticUI;
	import ui.WindowsFeature;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class CreditsWindow  extends Sprite
	{	
		private var flow:IUpdateDispatcher;
		
		public function CreditsWindow(flow:IUpdateDispatcher, name:String = "CreditsWindow") 
		{
			this.name = WindowsFeature.CREDITS;
			
			var tmp:Quad = new Quad(150, 100, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
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