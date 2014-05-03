package listeners 
{
	import flash.ui.Keyboard;
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
			if (keyUp)
			{
				if (keyCode == Keyboard.P)
				{
					this.flow.dispatchUpdate(Update.newGame);
				}
				else if (keyCode == Keyboard.M)
				{
					this.flow.dispatchUpdate(Update.toggleMute);
				}
			}
		}
	}

}