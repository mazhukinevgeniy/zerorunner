package ui.navigation 
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Navigation extends Sprite
	{
		private var panel:Panel;
		private var menu:Menu;
		
		public function Navigation(flow:IUpdateDispatcher) 
		{
			this.addChild(this.menu = new Menu(flow));
			this.addChild(this.panel = new Panel(flow));
			
			this.panel.visible = false;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.quitGame);
			
		}
		
		update function newGame():void
		{
			this.panel.visible = true;
			this.menu.visible = false;
		}
		
		update function quitGame():void
		{
			this.menu.visible = true;
			this.panel.visible = false;
		}
	}

}