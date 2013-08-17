package game.utils 
{
	import game.input.IKnowInput;
	import starling.animation.Juggler;
	import starling.textures.TextureAtlas;
	import utils.updates.IUpdateDispatcher;
	
	public class GameFoundations 
	{
		private var _flow:IUpdateDispatcher;
		private var _juggler:Juggler;
		private var _atlas:TextureAtlas;
		private var _input:IKnowInput;
		
		public function GameFoundations(flow:IUpdateDispatcher, juggler:Juggler, atlas:TextureAtlas, input:IKnowInput) 
		{
			this._atlas = atlas;
			this._flow = flow;
			this._juggler = juggler;
			this._input = input;
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