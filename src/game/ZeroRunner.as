package game 
{
	import data.DatabaseManager;
	import data.StatusReporter;
	import game.core.GameFoundations;
	import game.hud.UIExtendsions;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ZeroRunner
	{
		private var flow:IUpdateDispatcher;
		
		private var _foundations:GameFoundations;
		
		
		public function ZeroRunner(flow:IUpdateDispatcher, database:DatabaseManager, assets:AssetManager, root:Sprite) 
		{
			this.flow = flow;
			
			new GameUpdateConverter(flow, database.config);
			
			
			this._foundations = new GameFoundations(flow, database, assets, root);
			//So we wind up having the same parameters here and there? Ironical.
			//TODO: check if it's wise to divide ZeroRunner and GameFoundations
			//TODO: also check if we need the class named "ZeroRunner"
			//TODO: i take it "Game" will be just fine... oops, we already have one. Must think more.
			
			new UIExtendsions(foundations);
		}
		
		public function get foundations():GameFoundations
		{
			return this._foundations;
		}
	}

}