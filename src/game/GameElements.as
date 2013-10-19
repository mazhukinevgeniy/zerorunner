package game 
{
	import data.DatabaseManager;
	import game.core.input.InputManager;
	import game.core.time.Time;
	import game.hud.UIExtendsions;
	import game.world.ActorsFeatures;
	import game.world.IActors;
	import game.world.IActorTracker;
	import game.world.IScene;
	import game.world.items.utils.IPointCollector;
	import game.world.items.utils.PointsOfInterest;
	import game.world.renderer.Renderer;
	import game.world.SceneFeatures;
	import starling.animation.Juggler;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.UpdateManager;
	
	public class GameElements 
	{
		private var _scene:IScene;
		private var _juggler:Juggler;
		private var _input:InputManager;
		private var _assets:AssetManager;
		private var _actors:ActorsFeatures;
		private var _flow:IUpdateDispatcher;
		private var _points:IPointCollector;
		private var _database:DatabaseManager;
		private var _root:DisplayObjectContainer;
		
		public function GameElements(assets:AssetManager) 
		{
			this._assets = assets;
			this._root = new Sprite();
			this._flow = new UpdateManager();
			this._database = new DatabaseManager(this._flow);
			
			new GameUpdateConverter(this._flow, this._database.config);
			
			this._points = new PointsOfInterest();
			this._juggler = new Juggler();
			this._input = new InputManager(this._flow);
			this._scene = new SceneFeatures(this._flow);
			this._actors = new ActorsFeatures(this);
			
			new Renderer(this);
			new Time(this, this._database.status);
			new UIExtendsions(this);
		}
		
		public function get atlas():TextureAtlas
		{
			return this._assets.getTextureAtlas("gameAtlas");
		}
		
		public function get assets():AssetManager
		{
			return this._assets;
		}
		
		public function get juggler():Juggler
		{
			return this._juggler;
		}
		
		public function get flow():IUpdateDispatcher
		{
			return this._flow;
		}
		
		public function get input():InputManager
		{
			return this._input;
		}
		
		public function get actorsTracker():IActorTracker
		{
			return this._actors;
		}
		
		public function get actors():IActors
		{
			return this._actors;
		}
		
		public function get scene():IScene
		{
			return this._scene;
		}
		
		public function get displayRoot():DisplayObjectContainer
		{
			return this._root;
		}
		
		public function get pointsOfInterest():IPointCollector
		{
			return this._points;
		}
		
		public function get database():DatabaseManager
		{
			return this._database;
		}
	}

}