package ui.credits 
{
	import chaotic.core.IUpdateDispatcher;
	import feathers.controls.ScrollContainer;
	import starling.display.Quad;
	
	public class CreditsWindow  extends ScrollContainer
	{	
		private var flow:IUpdateDispatcher;
		
		public static const WIDTH_CREDITS_WINDOW:Number = 150;
		public static const HEIGHT_CREDITS_WINDOW:Number = 100;
		
		public function CreditsWindow(flow:IUpdateDispatcher) 
		{
			this.width = CreditsWindow.WIDTH_CREDITS_WINDOW;
			this.height = CreditsWindow.HEIGHT_CREDITS_WINDOW;
			
			var tmp:Quad = new Quad(CreditsWindow.WIDTH_CREDITS_WINDOW, CreditsWindow.HEIGHT_CREDITS_WINDOW, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.flow = flow;
		}
	}

}