package game.core 
{
	import data.viewers.GameConfig;
	import game.core.input.InputManager;
	import game.core.time.Time;
	import game.world.ActorsFeatures;
	import game.world.IActors;
	import game.world.IActorTracker;
	import game.world.IScene;
	import game.world.items.utils.IPointCollector;
	import game.world.items.utils.PointsOfInterest;
	import game.world.renderer.Renderer;
	import game.world.SceneFeatures;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	
	public class GameFoundations 
	{
		private var _scene:IScene;
		private var _juggler:Juggler;
		private var _config:GameConfig;
		private var _input:InputManager;
		private var _assets:AssetManager;
		private var _actors:ActorsFeatures;
		private var _flow:IUpdateDispatcher;
		private var _points:IPointCollector;
		private var _root:DisplayObjectContainer;
		
		public function GameFoundations(flow:IUpdateDispatcher, config:GameConfig, assets:AssetManager, root:Sprite) 
		{
			this._root = root;
			this._flow = flow;
			this._assets = assets;
			this._config = config;
			this._points = new PointsOfInterest();
			this._juggler = new Juggler();
			this._input = new InputManager(flow);
			this._scene = new SceneFeatures(flow);
			this._actors = new ActorsFeatures(this);
			
			new Renderer(this);
			
			new Time(this);
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
		
		public function get config():GameConfig
		{
			return this._config;
		}
	}

}