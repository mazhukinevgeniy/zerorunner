package ui 
{
	import chaotic.core.Chaotic;
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import ui.sounds.Sounds;
	import ui.windows.Windows;
	
	public class ChaoticUI extends Chaotic
	{
		public static const keyUp:String = "keyUp";
		
		[Embed(source="../../res/assets/fonts/HiLoDeco.ttf", embedAsCFF="false", fontFamily="HiLo-Deco")]
		private static const HiLoDeco:Class;
		
		
		private var masterFlow:IUpdateDispatcher;
		private var assets:AssetManager;
		private var root:DisplayObjectContainer;
		
		public function ChaoticUI(displayRoot:DisplayObjectContainer, masterFlow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.masterFlow = masterFlow;
			this.root = displayRoot;
			this.assets = assets;
			
			super();
		}
		
		override protected function addFeatures():void
		{
			var flow:IUpdateDispatcher = this.updateFlow;
			
			new Windows(this.root, flow);
			new Sounds(this.root, flow, this.assets);
		}
	}

}