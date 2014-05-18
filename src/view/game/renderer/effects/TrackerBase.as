package view.game.renderer.effects 
{
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import model.utils.normalize;
	import view.game.renderer.structs.Effect;
	
	internal class TrackerBase implements INewGameHandler, IGameFrameHandler
	{
		protected var tracked:Array;
		
		public function TrackerBase() 
		{
			
		}
		
		public function newGame():void
		{
			this.tracked = new Array();
		}
		
		public function gameFrame(frame:int):void
		{
			for (var key:String in this.tracked)
			{
				this.tracked[key].duration--;
				
				if (this.tracked[key].duration == 0)
					delete this.tracked[key];
			}
		}
		
		internal function getEffect(x:int, y:int):Effect
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.tracked[x + y * Game.MAP_WIDTH];
		}
	}

}