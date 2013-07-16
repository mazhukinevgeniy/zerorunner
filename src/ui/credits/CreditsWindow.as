package ui.credits 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class CreditsWindow  extends Sprite
	{	
		private var flow:IUpdateDispatcher;
		
		public function CreditsWindow(flow:IUpdateDispatcher, name:String = "CreditsWindow") 
		{
			this.name = name;
			
			var tmp:Quad = new Quad(150, 100, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
			this.visible = false;
			
			this.flow = flow;
		}
	}

}