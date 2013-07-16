package ui.achievements 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class AchievementsWindow  extends Sprite
	{	
		private var flow:IUpdateDispatcher;
		
		public function AchievementsWindow(flow:IUpdateDispatcher, name:String = "AchievementsWindow") 
		{
			this.name = name;
			
			var tmp:Quad = new Quad(350, 400, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
			this.visible = false;
			
			this.flow = flow;
		}
		
	}

}