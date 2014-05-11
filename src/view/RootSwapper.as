package view 
{
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import starling.display.DisplayObject;
	
	internal class RootSwapper implements INewGameHandler, IQuitGameHandler
	{
		private var game:DisplayObject;
		private var shell:DisplayObject;
		
		public function RootSwapper(shellRoot:DisplayObject, gameRoot:DisplayObject, binder:IBinder) 
		{
			this.game = gameRoot;
			this.shell = shellRoot;
			
			binder.notifier.addObserver(this);
		}
		
		public function newGame():void
		{
			this.game.visible = true;
			this.shell.visible = false;
		}
		
		public function quitGame():void
		{
			this.game.visible = false;
			this.shell.visible = true;
		}
	}

}