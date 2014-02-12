package game 
{
	import data.DatabaseManager;
	import game.core.input.InputManager;
	import game.core.time.Time;
	import game.fuel.FuelTracker;
	import game.fuel.IFuel;
	import game.hud.UIExtendsions;
	import game.items.Items;
	import game.points.IPointCollector;
	import game.points.PointsOfInterest;
	import game.projectiles.IProjectileManager;
	import game.projectiles.Projectiles;
	import game.renderer.Renderer;
	import game.scene.IScene;
	import game.scene.Scene;
	import starling.animation.Juggler;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.UpdateManager;
	
	public class GameElements 
	{
		private var _fuel:IFuel;
		private var _items:Items;
		private var _scene:IScene;
		private var _juggler:Juggler;
		private var _input:InputManager;
		private var _assets:AssetManager;
		private var _flow:IUpdateDispatcher;
		private var _points:IPointCollector;
		private var _database:DatabaseManager;
		private var _root:DisplayObjectContainer;
		private var _projectiles:IProjectileManager;
		
		public function GameElements(assets:AssetManager) 
		{
			this._assets = assets;
			this._root = new Sprite();
			this._flow = new UpdateManager();
			this._database = new DatabaseManager(this._flow);
			
			new GameUpdateConverter(this._flow, this._database.config);
			
			this._points = new PointsOfInterest(this._flow);
			this._juggler = new Juggler();
			this._input = new InputManager(this._flow);
			
			this._scene = new Scene(this._flow);
			this._items = new Items(this);
			this._fuel = new FuelTracker(this);
			this._projectiles = new Projectiles(this);
			
			new Renderer(this);
			
			new Time(this);
			new UIExtendsions(this);
		}
		
		public function get fuel():IFuel { return this._fuel; }
		public function get items():Items { return this._items; }
		public function get scene():IScene { return this._scene; }
		public function get juggler():Juggler { return this._juggler; }
		public function get input():InputManager { return this._input; }
		public function get assets():AssetManager { return this._assets; }
		public function get flow():IUpdateDispatcher { return this._flow; }
		public function get database():DatabaseManager { return this._database; }
		public function get pointsOfInterest():IPointCollector { return this._points; }
		public function get displayRoot():DisplayObjectContainer { return this._root; }
		public function get projectiles():IProjectileManager { return this._projectiles; }
	}

}