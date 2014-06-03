package view 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import feathers.core.PopUpManager;
	import starling.display.DisplayObjectContainer;
	
	internal class RootSwapper
	{
		private var game:DisplayObjectContainer;
		private var shell:DisplayObjectContainer;
		
		public function RootSwapper(shellRoot:DisplayObjectContainer, 
		                            gameRoot:DisplayObjectContainer, 
									binder:IBinder) 
		{
			this.game = gameRoot;
			this.shell = shellRoot;
			
			binder.eventDispatcher.addEventListener(GlobalEvent.NEW_GAME,
			                                        this.newGame);
			binder.eventDispatcher.addEventListener(GlobalEvent.QUIT_GAME,
			                                        this.quitGame);
			
			PopUpManager.root = shellRoot;
		}
		
		private function newGame():void
		{
			this.game.visible = true;
			this.shell.visible = false;
			
			PopUpManager.root = this.game;
		}
		
		private function quitGame():void
		{
			this.game.visible = false;
			this.shell.visible = true;
			
			PopUpManager.root = this.shell;
		}
	}

}