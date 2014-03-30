package ui.windows.credits 
{
	import feathers.controls.ScrollContainer;
	import starling.display.Quad;
	import starling.events.Event;
	import ui.navigation.Navigation;
	import utils.updates.IUpdateDispatcher;
	
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
			
			this.addEventListener(Event.ADDED_TO_STAGE, this.alignCenter);
			
			this.flow = flow;
		}
		
		private function alignCenter():void
		{
			this.x = (Main.WIDTH + Navigation.WIDTH - this.width) / 2;
			this.y = (Main.HEIGHT - this.height) / 2;
		}
	}

}