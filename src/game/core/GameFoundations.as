package game.core 
{
	import game.core.input.IKnowInput;
	import game.core.input.InputManager;
	import game.core.time.Time;
	import game.data.IGame;
	import game.world.ActorsFeatures;
	import game.world.IActorTracker;
	import game.world.ISearcher;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import utils.updates.IUpdateDispatcher;
	
	public class GameFoundations 
	{
		private var _game:IGame;
		private var _juggler:Juggler;
		private var _atlas:TextureAtlas;
		private var _input:IKnowInput;
		private var _actors:IActorTracker;
		private var _flow:IUpdateDispatcher;
		
		public function GameFoundations(flow:IUpdateDispatcher, game:IGame, atlas:TextureAtlas, root:Sprite) 
		{
			this._flow = flow;
			this._game = game;
			this._atlas = atlas;
			this._juggler = new Juggler();
			this._input = new InputManager(flow);
			this._actors = new ActorsFeatures(this);
			
			new Time(root, this);
		}
		
		public function get game():IGame
		{
			return this._game;
		}
		
		public function get atlas():TextureAtlas
		{
			return this._atlas;
		}
		
		public function get juggler():Juggler
		{
			return this._juggler;
		}
		
		public function get flow():IUpdateDispatcher
		{
			return this._flow;
		}
		
		public function get input():IKnowInput
		{
			return this._input;
		}
		
		public function get actors():IActorTracker
		{
			return this._actors;
		}
		
		public function get world():ISearcher
		{
			return this._actors as ISearcher;
		}
	}

}