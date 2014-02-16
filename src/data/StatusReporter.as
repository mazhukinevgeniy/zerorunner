package data
{
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class StatusReporter 
	{
		private var save:SharedObjectManager;
		
		private var _isGameOn:Boolean = false;
		private var _isMapOn:Boolean = false;
		
		public function StatusReporter(flow:IUpdateDispatcher, save:SharedObjectManager) 
		{
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.toggleMap);
			flow.addUpdateListener(Update.quitGame);
		}
		
		update function newGame():void
		{
			this._isGameOn = true;
			this._isMapOn = false;
		}
		
		update function toggleMap():void
		{
			this._isMapOn = !this._isMapOn;
		}
		
		update function quitGame():void
		{
			this._isGameOn = false;
			this._isMapOn = false;
		}
		
		public function get isGameOn():Boolean { return this._isGameOn; }
		public function get isMapOn():Boolean { return this._isMapOn; }
	}

}