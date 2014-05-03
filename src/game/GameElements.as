package game 
{
	import data.Preferences;
	import data.StatusReporter;
	import game.fuel.FuelTracker;
	import game.fuel.IFuel;
	import game.input.IKnowInput;
	import game.input.InputManager;
	import game.items.Items;
	import game.projectiles.IProjectileManager;
	import game.projectiles.Projectiles;
	import game.scene.IScene;
	import game.scene.Scene;
	import game.ui.GameUI;
	import game.ui.IGameMenu;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.UpdateManager;
	
	public class GameElements 
	{
		private var _assets:AssetManager;
		private var _status:StatusReporter;
		private var _preferences:Preferences;
		private var _flow:IUpdateDispatcher;
		private var _root:DisplayObjectContainer;
		
		private var _fuel:IFuel;
		
		private var _items:Items;
		private var _scene:IScene;
		private var _projectiles:IProjectileManager;
		
		private var _input:IKnowInput;
		
		private var _gameMenu:IGameMenu;
		
		public function GameElements(assets:AssetManager) 
		{
			this._assets = assets;
			this._root = new Sprite();
			this._flow = new UpdateManager();
			this._status = new StatusReporter(this._flow);
			this._preferences = new Preferences(this._flow);
			
			new GameUpdateConverter(this._flow);
			
			this._input = new InputManager(this._flow);
			
			this._scene = new Scene(this._flow);
			this._items = new Items(this);
			this._fuel = new FuelTracker(this);
			this._projectiles = new Projectiles(this);
			
			new Time(this);
			
			this._gameMenu = new GameUI(this).gameMenu;
		}
		
		public function get fuel():IFuel { return this._fuel; }
		public function get items():Items { return this._items; }
		public function get scene():IScene { return this._scene; }
		public function get input():IKnowInput { return this._input; }
		public function get assets():AssetManager { return this._assets; }
		public function get gameMenu():IGameMenu { return this._gameMenu; }
		public function get flow():IUpdateDispatcher { return this._flow; }
		public function get status():StatusReporter { return this._status; }
		public function get preferences():Preferences { return this._preferences; }
		public function get displayRoot():DisplayObjectContainer { return this._root; }
		public function get projectiles():IProjectileManager { return this._projectiles; }
	}

}