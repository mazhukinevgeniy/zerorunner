package data
{
	import game.items.PuppetBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class StatusReporter 
	{
		private var save:SharedObjectManager;
		
		private var hero:PuppetBase;
		
		private var _isGameOn:Boolean = false;
		private var _isMapOn:Boolean = false;
		
		public function StatusReporter(flow:IUpdateDispatcher, save:SharedObjectManager) 
		{
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.setCenter);
			flow.addUpdateListener(Update.toggleMap);
			flow.addUpdateListener(Update.quitGame);
		}
		
		update function newGame():void
		{
			this._isGameOn = true;
			this._isMapOn = false;
		}
		
		update function setCenter(hero:PuppetBase):void
		{
			this.hero = hero;
		}
		
		update function toggleMap():void
		{
			this._isMapOn = !this._isMapOn;
		}
		
		update function quitGame():void
		{
			this._isGameOn = false;
			this._isMapOn = false;
			
			this.hero = null;
		}
		
		public function get isGameOn():Boolean { return this._isGameOn; }
		public function get isMapOn():Boolean { return this._isMapOn; }
		public function isHeroFree():Boolean { return this.hero && this.hero.isFree(); }
		
		//TODO: remove keyword "get"
	}

}