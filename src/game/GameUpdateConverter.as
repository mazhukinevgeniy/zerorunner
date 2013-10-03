package game 
{
	import game.data.GameSave;
	import game.data.LevelConfiguration;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.errors.AbstractClassError;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	final internal class GameUpdateConverter
	{
		private var displayRoot:Sprite;
		
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
			flow.addUpdateListener(Update.resetProgress);
			flow.addUpdateListener(Update.setGameContainer);
			flow.addUpdateListener(Update.smallBeaconTurnedOn);
		}
		
		final update function setGameContainer(viewRoot:Sprite):void
		{
			this.displayRoot = viewRoot;
			this.displayRoot.stage.color = 0;
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
		
		update function smallBeaconTurnedOn():void
		{
			this.save.setBeacon(this.save.level, Game.BEACON);
			
			if (this.save.level == Game.LEVELS_PER_RUN)
				this.flow.dispatchUpdate(Update.tellGameWon);
			else
				this.flow.dispatchUpdate(Update.tellRoundWon);
			
			this.applyConfiguration(new LevelConfiguration(this.save));
			
			
			this.flow.dispatchUpdate(Update.gameStopped);
		}
		
		
		
		update function gameOver():void
		{
			this.flow.dispatchUpdate(Update.gameStopped);
		}
		
		
		
		update function resetProgress():void
		{
			this.applyConfiguration(new LevelConfiguration(null));
		}
		
		
		private function applyConfiguration(params:LevelConfiguration):void
		{
			this.save.mapWidth = params.mapWidth;
			this.save.level = params.level;
			
			if (params.level == 1)
				for (var i:int = 0; i < Game.LEVELS_PER_RUN; i++)
					this.save.setBeacon(i + 1, Game.NO_BEACON);
		}
	}

}