package model.status
{
	import binding.IBinder;
	import controller.observers.game.INewGameHandler;
	import controller.observers.game.IQuitGameHandler;
	import controller.observers.map.IMapStatusObserver;
	import model.interfaces.IStatus;
	import model.items.PuppetBase;
	import model.metric.DCellXY;
	import model.metric.ICoordinated;
	
	public class StatusReporter implements IStatus, 
	                                       INewGameHandler, 
										   IQuitGameHandler,
										   IMapStatusObserver
	{
		private var hero:PuppetBase;
		
		private var _isGameOn:Boolean = false;
		private var _isMapOn:Boolean = false;
		
		private var dxyHelper:NumericalDxyHelper;
		
		public function StatusReporter(binder:IBinder) 
		{
			binder.notifier.addGameStatusObserver(this);
			binder.notifier.addMapStatusObserver(this);
			
			this.dxyHelper = new NumericalDxyHelper();
		}
		
		public function newGame():void
		{
			this._isGameOn = true;
			this._isMapOn = false;
		}
		
		public function setVisibilityOfMap(visible:Boolean):void
		{
			this._isMapOn = visible;
		}
		
		public function quitGame():void
		{
			this._isGameOn = false;
			this._isMapOn = false;
			
			this.hero = null;
		}
		
		
		public function newHero(hero:PuppetBase):void
		{
			this.hero = hero;
		}
		
		/**///As IStatus
		
		public function isGameOn():Boolean { return this._isGameOn; }
		public function isMapOn():Boolean { return this._isMapOn; }
		
		public function isHeroFree():Boolean { return this.hero && this.hero.isFree(); }
		public function getLocationOfHero():ICoordinated { return this.hero; }
		
		public function getDisplacementOfHero():NumericalDxyHelper
		{
			var occ:int = this.hero.occupation;
			
			if (occ == Game.OCCUPATION_MOVING)
			{
				var direction:DCellXY = this.hero.moveInProgress;
				
				var progress:Number = this.hero.getProgress() - 1;
				
				this.dxyHelper.setValue(progress * direction.x, progress * direction.y);
			}
			else
			{
				this.dxyHelper.setValue(0, 0);
			}
			
			return this.dxyHelper;
		}
		
		/**/
	}

}