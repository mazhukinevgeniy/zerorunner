package model.status
{
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import controller.observers.IScreenObserver;
	import model.interfaces.IStatus;
	import model.items.PuppetBase;
	import model.metric.DCellXY;
	import model.metric.ICoordinated;
	
	public class StatusReporter implements IStatus, 
	                                       INewGameHandler,
										   IQuitGameHandler,
										   IScreenObserver
	{
		private var gameScreens:Vector.<String> = Vector.<String>(
		[View.GAME_SCREEN_MAP, View.GAME_SCREEN_LOST, View.GAME_SCREEN_WON,
			 View.GAME_SCREEN_MENU, View.GAME_SCREEN_OBSERVER]);
		
		private var hero:PuppetBase;
		
		private var _screen:String;
		
		private var dxyHelper:NumericalDxyHelper;
		
		public function StatusReporter(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
			
			this.dxyHelper = new NumericalDxyHelper();
		}
		
		public function screenActivated(name:String):void
		{
			this._screen = name;
		}
		
		public function newGame():void
		{
			this._screen = View.GAME_SCREEN_OBSERVER;
		}
		
		public function quitGame():void
		{
			this._screen = View.SHELL_SCREEN_MAIN;
			
			this.hero = null;
		}
		
		public function newHero(hero:PuppetBase):void
		{
			this.hero = hero;
		}
		
		/**///As IStatus
		
		public function isGameOn():Boolean 
		{ 
			return this.gameScreens.indexOf(this._screen) != -1; 
		}
		public function isMapOn():Boolean 
		{ 
			return this._screen == View.GAME_SCREEN_MAP; 
		}
		public function isMenuOn():Boolean 
		{ 
			return this._screen == View.GAME_SCREEN_MENU; 
		}
		
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