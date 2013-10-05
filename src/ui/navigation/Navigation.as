package ui.navigation 
{
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import ui.Windows;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Navigation extends Sprite
	{
		private var panel:Panel;
		private var menu:Menu;
		private var compactMenu:CompactMenu;
		
		private var menus:Vector.<DisplayObject>;
		
		public function Navigation(flow:IUpdateDispatcher) 
		{
			this.addChild(this.menu = new Menu(flow));
			this.addChild(this.panel = new Panel(flow));
			this.addChild(this.compactMenu = new CompactMenu(flow));
			
			this.menus = new <DisplayObject>[this.menu, this.compactMenu, this.panel];
			this.hideAllBut(this.menu);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.quitGame);
			flow.addUpdateListener(Update.toggleWindow);
			
		}
		
		update function newGame():void
		{
			this.hideAllBut(this.panel);
		}
		
		update function quitGame():void
		{
			this.hideAllBut(this.menu);
		}
		
		update function toggleWindow(key:int):void
		{
			if (this.compactMenu.visible)
				this.hideAllBut(this.menu);
			else if (key == Windows.ACHIEVEMENTS)
				this.hideAllBut(this.compactMenu);
		}
		
		
		private function hideAllBut(item:DisplayObject):void
		{
			item.visible = true;
			
			for (var i:int = 0; i < 3; i++)
				if (menus[i] != item)
					menus[i].visible = false;
		}
	}

}