package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class StatisticsWindow  extends Sprite
	{	
		private var flow:IUpdateDispatcher;
		
		public function StatisticsWindow(flow:IUpdateDispatcher, name:String = "StatisticsWindow") 
		{
			this.name =  name;
			
			var tmp:Quad = new Quad(250, 250, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
			this.visible = false;
			
			this.flow = flow;
		}
		
	}

}