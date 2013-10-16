package  
{
	import data.structs.GameConfig;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class StatusReporter 
	{
		
		private var _isGameOn:Boolean = false;
		private var _config:GameConfig = null;
		
		public function StatusReporter(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.quitGame);
		}
		
		update function newGame():void
		{
			this._config = new GameConfig(//now you think, what is the right place to generate config? when?
		}
		
		update function prerestore(config:GameConfig):void
		{
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