package model.status
{
	import binding.IBinder;
	import binding.IDependent;
	import events.GlobalEvent;
	import model.interfaces.IItemSnapshotter;
	import model.interfaces.IStatus;
	import model.items.ItemBase;
	import model.items.ItemSnapshot;
	import model.metric.DCellXY;
	import model.metric.ICoordinated;
	import starling.events.Event;
	import utils.getCellId;
	
	public class StatusReporter implements IStatus,
										   IDependent
	{
		private var gameScreens:Vector.<String> = Vector.<String>(
		[View.GAME_SCREEN_MAP, View.GAME_SCREEN_LOST, View.GAME_SCREEN_WON,
			 View.GAME_SCREEN_MENU, View.GAME_SCREEN]);
		
		private var hero:ItemBase;
		private var items:IItemSnapshotter;
		
		private var _screen:String;
		private var _gameStopped:Boolean;
		
		public function StatusReporter(binder:IBinder) 
		{
			binder.eventDispatcher.addEventListener(GlobalEvent.SCREEN_ACTIVATED,
			                                        this.screenActivated);
			binder.eventDispatcher.addEventListener(GlobalEvent.NEW_GAME,
			                                        this.newGame);
			binder.eventDispatcher.addEventListener(GlobalEvent.QUIT_GAME,
			                                        this.quitGame);
			binder.eventDispatcher.addEventListener(GlobalEvent.GAME_STOPPED,
			                                        this.gameStopped);
			
			binder.requestBindingFor(this);
		}
		
		public function bindObjects(binder:IBinder):void
		{
			this.items = binder.itemSnapshotter;
		}
		
		private function screenActivated(event:Event, name:String):void
		{
			this._screen = name;
		}
		
		private function newGame():void
		{
			this._screen = View.GAME_SCREEN;
			this._gameStopped = false;
		}
		
		private function gameStopped(event:Event, reason:int):void
		{
			this._gameStopped = true;
		}
		
		private function quitGame():void
		{
			this._screen = View.SHELL_SCREEN_MAIN;
			
			this.hero = null;
		}
		
		public function newHero(hero:ItemBase):void
		{
			this.hero = hero;
		}
		
		/**///As IStatus
		
		public function isGameOn():Boolean 
		{ 
			return this.gameScreens.indexOf(this._screen) != -1; 
		}
		public function isGameStopped():Boolean
		{
			return !this.isGameOn() || this._gameStopped;
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
		
		//TODO: this class is too big, fix that
	}

}