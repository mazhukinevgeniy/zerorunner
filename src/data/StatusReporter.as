package data
{
	import data.structs.GameConfig;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class StatusReporter 
	{
		private var save:SharedObjectManager;
		
		private var _isGameOn:Boolean = false;
		private var _config:GameConfig = null;
		
		public function StatusReporter(flow:IUpdateDispatcher, save:SharedObjectManager) 
		{
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.quitGame);
		}
		
		update function newGame():void
		{
			this._config = new GameConfig(save.width, save.junks, save.goal, save.level, save.activeDroids);
			
			this._isGameOn = true;
		}
		
		update function quitGame():void
		{
			this._config = null;
			this._isGameOn = false;
		}
		
		public function get isGameOn():Boolean { return this._isGameOn; }
		public function get currentConfig():GameConfig { return this._config; }
	}

}