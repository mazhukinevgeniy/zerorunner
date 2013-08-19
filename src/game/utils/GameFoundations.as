package game.utils 
{
	import game.IGame;
	import game.utils.achievements.AchievementsFeature;
	import game.utils.input.IKnowInput;
	import game.utils.input.InputManager;
	import game.utils.statistics.StatisticsFeature;
	import game.utils.time.Time;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import utils.updates.IUpdateDispatcher;
	
	public class GameFoundations 
	{
		private var _game:IGame;
		private var _flow:IUpdateDispatcher;
		private var _juggler:Juggler;
		private var _atlas:TextureAtlas;
		private var _input:IKnowInput;
		
		public function GameFoundations(game:ZeroRunner, atlas:TextureAtlas, root:Sprite) 
		{
			this._game = game;
			this._atlas = atlas;
			this._flow = game;
			this._juggler = new Juggler();
			this._input = new InputManager(game);
			
			new Time(root, this);
			
			new StatisticsFeature(game);
			new AchievementsFeature(game);
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
	}

}