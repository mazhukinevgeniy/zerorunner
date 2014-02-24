package view.features.input 
{
	import chaotic.core.commands.ICommand;
	import view.features.input.directions.Directions;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	
	internal class DirectionControls extends Directions implements IMouseControls
	{
		
		public function DirectionControls() 
		{
			var tmp:Quad = new Quad(90, 90, 0xCC9966);
			tmp.alpha = Number.MIN_VALUE;
			tmp.x = Constants.WIDTH / 2 - 45;
			tmp.y = Constants.HEIGHT / 2 - 45;
			this.addChild(tmp);
			
			this.addEventListener(TouchEvent.TOUCH, this.touchLost);
			
			this.visible = false;
		}
		
		internal function setCommand(item:ICommand):void
		{
			this.newInputPiece = item;
		}
	
		protected function touchLost(event:TouchEvent):void
		{
			if (event.getTouch( //lol, what am i doing, this class is totally inactive
			this.hideAll();
			this.visible = false;
		}
		
		
		public function showMouseControls():void
		{
			this.visible = true;
		}
	}

}