package chaotic.ui 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.game.ChaoticGame;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class GrindedToDeath
	{
		private var message:Sprite;
		
		public function GrindedToDeath(flow:IUpdateDispatcher) 
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
			
			flow.addUpdateListener(ChaoticGame.restore);
			flow.addUpdateListener(ChaoticGame.gameOver);
			
			flow.dispatchUpdate(ChaoticGame.addToTheHUD, this.message);
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