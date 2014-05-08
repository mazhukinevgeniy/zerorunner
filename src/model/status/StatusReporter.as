package model.status
{
	import binding.IBinder;
	import controller.observers.game.INewGameHandler;
	import controller.observers.game.IQuitGameHandler;
	import model.interfaces.IStatus;
	import model.items.PuppetBase;
	import model.metric.ICoordinated;
	
	public class StatusReporter implements IStatus, 
	                                       INewGameHandler, 
										   IQuitGameHandler
	{
		private var hero:PuppetBase;
		
		private var _isGameOn:Boolean = false;
		private var _isMapOn:Boolean = false;
		
		private var dxyHelper:NumericalDxyHelper;
		
		public function StatusReporter(binder:IBinder) 
		{
			binder.notifier.addGameStatusObserver(this);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.toggleMap);
			
			this.dxyHelper = new NumericalDxyHelper();
		}
		
		public function newGame():void
		{
			this._isGameOn = true;
			this._isMapOn = false;
		}
		
		update function toggleMap():void
		{
			this._isMapOn = !this._isMapOn;
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
			
			if (occ == Game.OCCUPATION_MOVING || occ == Game.OCCUPATION_FLYING)
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
		
		public function isHeroAirborne():Boolean
		{
			var occ:int = this.hero.occupation;
			
			return occ == Game.OCCUPATION_FLYING || occ == Game.OCCUPATION_FLOATING;
		}
		
		/**/
	}

}