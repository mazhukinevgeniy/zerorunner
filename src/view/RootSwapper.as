package view 
{
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import feathers.core.PopUpManager;
	import starling.display.DisplayObjectContainer;
	
	internal class RootSwapper implements INewGameHandler, IQuitGameHandler
	{
		private var game:DisplayObjectContainer;
		private var shell:DisplayObjectContainer;
		
		public function RootSwapper(shellRoot:DisplayObjectContainer, 
		                            gameRoot:DisplayObjectContainer, 
									binder:IBinder) 
		{
			this.game = gameRoot;
			this.shell = shellRoot;
			
			binder.notifier.addObserver(this);
			
			PopUpManager.root = shellRoot;
		}
		
		public function newGame():void
		{
			this.game.visible = true;
			this.shell.visible = false;
			
			PopUpManager.root = this.game;
		}
		
		public function quitGame():void
		{
			this.game.visible = false;
			this.shell.visible = true;
			
			PopUpManager.root = this.shell;
		}
	}

}