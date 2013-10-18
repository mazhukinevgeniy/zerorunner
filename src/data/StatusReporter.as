package data
{
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class StatusReporter 
	{
		private var save:SharedObjectManager;
		
		private var _isGameOn:Boolean = false;
		
		public function StatusReporter(flow:IUpdateDispatcher, save:SharedObjectManager) 
		{
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.gameFinished);
		}
		
		update function newGame():void
		{
			this._isGameOn = true;
		}
		
		update function gameFinished(key:int):void
		{
			this._isGameOn = false;
		}
		
		public function get isGameOn():Boolean { return this._isGameOn; }
	}

}