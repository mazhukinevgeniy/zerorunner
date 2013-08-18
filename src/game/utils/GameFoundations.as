package game.utils 
{
	import game.core.input.IKnowInput;
	import game.IGame;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.textures.TextureAtlas;
	import utils.updates.IUpdateDispatcher;
	
	public class GameFoundations 
	{
		private var _game:IGame;
		private var _flow:IUpdateDispatcher;
		private var _juggler:Juggler;
		private var _atlas:TextureAtlas;
		private var _input:IKnowInput;
		
		public function GameFoundations(game:ZeroRunner, juggler:Juggler, atlas:TextureAtlas, input:IKnowInput) 
		{
			this._game = game;
			this._atlas = atlas;
			this._flow = game;
			this._juggler = juggler;
			this._input = input;
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