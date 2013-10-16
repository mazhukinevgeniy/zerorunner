package game 
{
	import data.StatusReporter;
	import data.structs.GameConfig;
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
		private var status:StatusReporter;
		
		private var _foundations:GameFoundations;
		
		
		public function ZeroRunner(flow:IUpdateDispatcher, status:StatusReporter, assets:AssetManager, root:Sprite) 
		{
			this.flow = flow;
			this.status = status;
			
			new GameUpdateConverter(flow, status);
			
			
			this._foundations = new GameFoundations(flow, status, assets, root);
			
			new UIExtendsions(foundations);
		}
		
		public function get foundations():GameFoundations
		{
			return this._foundations;
		}
	}

}