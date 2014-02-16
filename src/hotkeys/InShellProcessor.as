package hotkeys 
{
	import game.GameElements;
	import utils.updates.IUpdateDispatcher;
	
	internal class InShellProcessor extends ProcessorBase
	{
		private var flow:IUpdateDispatcher;
		
		public function InShellProcessor(elements:GameElements) 
		{
			
			
			this.flow = elements.flow;
		}
		
		override internal function processInput(keyUp:Boolean, keyCode:uint):void 
		{
			/*if (keyCode == Keyboard.P && !this.status.isGameOn)
			{
				this.flow.dispatchUpdate(Update.newGame);//startGame
			}*/
			/*
			
			if (keyCode == Keyboard.M)
				this.update::toggleMute();//it's okay out of game
			*/
				
			//TODO: repair these important things
		}
	}

}