package game 
{
	import game.input.InputCollector;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	final internal class GameUpdateConverter
	{
		private var flow:IUpdateDispatcher;
		private var inputCollector:InputCollector;
		
		public function GameUpdateConverter(elements:GameElements) 
		{
			this.flow = elements.flow;
			this.inputCollector = elements.inputCollector;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.toggleMap);
			flow.addUpdateListener(Update.setVisibilityOfGameMenu);
		}
		
		
		update function newGame():void
		{
			this.flow.dispatchUpdate(Update.restore);
			
			this.inputCollector.clearInput();
		}
		
		update function toggleMap():void
		{
			this.inputCollector.clearInput();
		}
		
		update function setVisibilityOfGameMenu(visible:Boolean):void
		{
			this.inputCollector.clearInput();
		}
	}

}