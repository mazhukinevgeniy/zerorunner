package model.status
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import controller.observers.IScreenObserver;
	import model.interfaces.IPuppets;
	import model.interfaces.IStatus;
	import model.items.ItemSnapshot;
	import model.items.PuppetBase;
	import model.metric.DCellXY;
	import model.metric.ICoordinated;
	import utils.getCellId;
	
	public class StatusReporter implements IStatus, 
	                                       INewGameHandler,
										   IQuitGameHandler,
										   IScreenObserver,
										   IDependent
	{
		private var gameScreens:Vector.<String> = Vector.<String>(
		[View.GAME_SCREEN_MAP, View.GAME_SCREEN_LOST, View.GAME_SCREEN_WON,
			 View.GAME_SCREEN_MENU, View.GAME_SCREEN]);
		
		private var hero:PuppetBase;
		private var items:IPuppets;
		
		private var _screen:String;
		
		public function StatusReporter(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
			
			binder.requestBindingFor(this);
		}
		
		public function bindObjects(binder:IBinder):void
		{
			this.items = binder.puppets;
		}
		
		public function screenActivated(name:String):void
		{
			this._screen = name;
		}
		
		public function newGame():void
		{
			this._screen = View.GAME_SCREEN;
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
		
		public function getLocationOfHero():ICoordinated { return this.hero; }
		
		public function getSnapshotOfHero():ItemSnapshot 
		{ 
			return this.items.getItemSnapshot(getCellId(this.hero.x, this.hero.y));
		}
		/**/
	}

}