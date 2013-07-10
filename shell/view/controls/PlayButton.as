package view.controls 
{
	import starling.display.Button;
	import flash.utils.Timer;
	
	public class PlayButton extends Button
	{
		private var timer:Timer;
		
		private static const 
					NEW_SCALE_X:Number = 0.15,
					NEW_SCALE_Y:Number = 0.15,
					COUNT_STEPS:int = 5;
		
		
		private var 
				newX:int,
				newY:int,
				newWidth:int,
				newHeight:int,
				remainSteps:int,
				stepX:Number,
				stepY:Number,
				stepScaleX:Number,
				stepScaleY:Number;
		
		private var supervisor:IPlayButttonSupervisor;
		
		public function PlayButton(newSupervisor:IPlayButttonSupervisor) 
		{
			super(300, 300, "Play", 0xBBAA44);
			
			this.fontName = "HiLo-Deco"; this.fontSize = 18; this.fontSize = 18;
			
			this.x = Main.WIDTH / 2 - this.width / 2;
			this.y = Main.HEIGHT / 2 - this.height / 2;
			
			this.title.x = this.width / 2 - this.title.width / 2;
			this.title.y = this.height / 2 - this.title.height / 2;
			
			this.supervisor = newSupervisor;
			
			this.mouseChildren = false;
		}
		
		public function  minimize():void
		{	
			newWidth = int(this.width * PlayButton.NEW_SCALE_X);
			newHeight = int(this.height * PlayButton.NEW_SCALE_Y);
			newY = Main.HEIGHT - newHeight;
			newX = 0;
			
			this.remainSteps = PlayButton.COUNT_STEPS;
			this.timer = new Timer(20, this.remainSteps + 1);
			stepX = (this.x - newX) / this.remainSteps;
			stepY = ((newY - this.y) / this.remainSteps);
			
			stepScaleX = (this.scaleX - PlayButton.NEW_SCALE_X) / this.remainSteps;
			stepScaleY = (this.scaleY - PlayButton.NEW_SCALE_Y) / this.remainSteps;
			
			this.timer.addEventListener(TimerEvent.TIMER, nextStep);
			this.timer.start();
		}
		
		private function nextStep(event:TimerEvent):void
		{
			this.remainSteps -= 1;
			
			this.x = int(this.x - stepX);
			stepX = (this.x - newX) / this.remainSteps;
			
			this.y = int(this.y + stepY);
			stepY = ((newY - this.y) / this.remainSteps);
			
			this.scaleX -= stepScaleX;
			this.scaleY -= stepScaleY;
			
			if (this.remainSteps == 0)
			{
				this.scaleX = PlayButton.NEW_SCALE_X;
				this.scaleY = PlayButton.NEW_SCALE_Y;
				this.timer.removeEventListener(TimerEvent.TIMER, nextStep);
				this.timer.addEventListener(TimerEvent.TIMER, endOfMove);
			}
		}
		
		private function endOfMove(event:TimerEvent):void
		{
			this.supervisor.handleEndOfMove();
			this.timer.removeEventListener(TimerEvent.TIMER,  endOfMove);
			this.timer.stop();
		}
	}

}