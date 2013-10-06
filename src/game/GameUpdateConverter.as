package game 
{
	import game.core.metric.ICoordinated;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.errors.AbstractClassError;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	final internal class GameUpdateConverter
	{
		private var displayRoot:Sprite;
		//TODO: move addToTheHUD to the zeroRunner.as or further
		
		private var flow:IUpdateDispatcher;
		private var save:GameSave;
		
		public function GameUpdateConverter(flow:IUpdateDispatcher, save:GameSave) 
		{
			this.flow = flow;
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.gameOver);
			flow.addUpdateListener(Update.addToTheHUD);
			flow.addUpdateListener(Update.setGameContainer);
		}
		
		final update function setGameContainer(viewRoot:Sprite):void
		{
			this.displayRoot = viewRoot;
			Starling.current.stage.stage.color = 0;
		}
		
		
		update function newGame():void
		{
			this.flow.dispatchUpdate(Update.prerestore);
			this.flow.dispatchUpdate(Update.restore);
		}
		
		final update function addToTheHUD(item:DisplayObject):void
		{
			this.displayRoot.addChild(item);
		}
		
		
		
		update function gameOver():void
		{
			this.flow.dispatchUpdate(Update.gameStopped);
		}
		
	}

}