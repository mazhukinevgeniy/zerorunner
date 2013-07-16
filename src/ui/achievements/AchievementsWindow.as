package ui.achievements 
{
	import chaotic.core.IUpdateDispatcher;
	import feathers.controls.ScrollContainer;
	import starling.display.Quad;
	
	public class AchievementsWindow  extends ScrollContainer
	{	
		private var flow:IUpdateDispatcher;
		
		public static const WIDTH_ACHIEVMENTS_WINDOW:Number = 350;
		public static const HEIGHT_ACHIEVMENTS_WINDOW:Number = 400;
		
		public function AchievementsWindow(flow:IUpdateDispatcher, name:String = "AchievementsWindow") 
		{
			this.name = name;
			
			this.width = AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW;
			this.height = AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW;
			
			var tmp:Quad = new Quad(AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW, AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.visible = false;
			
			this.flow = flow;
		}
		
	}

}