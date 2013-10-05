package ui.navigation 
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import utils.updates.IUpdateDispatcher;
	
	public class Navigation extends Sprite
	{
		
		public function Navigation(flow:IUpdateDispatcher) 
		{
			this.addChild(new Menu(flow));
		}
		
	}

}