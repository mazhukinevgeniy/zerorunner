package hotkeys 
{
	
	internal class InShellProcessor extends ProcessorBase
	{
		
		public function InShellProcessor() 
		{
			
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
		}
	}

}