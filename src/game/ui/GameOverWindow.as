package game.ui 
{
	import chaotic.core.IUpdateDispatcher;
	import game.ZeroRunner;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class GameOverWindow
	{
		private var message:Sprite;
		
		public function GameOverWindow(flow:IUpdateDispatcher) 
		{
			this.message = new Sprite();
			
			var tmpI:Quad = new Quad(200, 200, 0xCCFF11);
			tmpI.alpha = 0.2;
			this.message.addChild(tmpI);
			
			this.message.x = (Main.WIDTH - this.message.width) / 2;
			this.message.y = (Main.HEIGHT - this.message.height) / 2;
			
			var tmp:TextField = new TextField(200, 20, "Game over, please quit using panel above.");
			
			this.message.addChild(tmp);
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.restore);
			flow.addUpdateListener(ZeroRunner.gameOver);
			
			flow.dispatchUpdate(ZeroRunner.addToTheHUD, this.message);
		}
		
		public function restore():void
		{
			this.message.visible = false;
		}
		
		public function gameOver():void
		{
			this.message.visible = true;	
		}
	}

}