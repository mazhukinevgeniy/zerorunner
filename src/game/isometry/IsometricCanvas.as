package game.isometry 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import flash.display.DisplayObject;
	import game.actors.core.ISearcher;
	import game.metric.Metric;
	import starling.display.Sprite;
	
	public class IsometricCanvas 
	{
		private var lines:Vector.<Sprite>;
		private var topLine:int;
		
		private var searcher:ISearcher;
		
		
		public function IsometricCanvas(flow:IUpdateDispatcher) 
		{
			var numberOfLines:int = Metric.CELLS_IN_VISIBLE_HEIGHT + 3 + (Metric.CELLS_IN_VISIBLE_HEIGHT % 2 == 0 ? 1 : 0);
			
			this.lines = new Vector.<Sprite>(Metric.yDistanceActorsAllowed * 2, true);
		}
		
		update function addToChildOfLine(object:DisplayObject, line:int):void
		{
			//if line is not suitable, ignore it
			
			//lol what? ignore nothing, useless requests are not required
			
		}
	}

}