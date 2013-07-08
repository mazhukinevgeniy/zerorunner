package chaotic.endings 
{
	import chaotic.core.ChaoticFeature;
	import chaotic.updates.IGameOverHandler;
	import chaotic.updates.IRestorable;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.updates.Update;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class GrindedToDeath extends ChaoticFeature implements IRestorable, IGameOverHandler
	{
		private var message:Sprite;
		
		public function GrindedToDeath() 
		{
			this.message = new Sprite();
			
			var tmpI:Quad = new Quad(200, 200, 0xCCFF11);
			tmpI.alpha = 0.2;
			this.message.addChild(tmpI);
			
			this.message.x = (Constants.WIDTH - this.message.width) / 2;
			this.message.y = (Constants.HEIGHT - this.message.height) / 2;
			
			var tmp:TextField = new TextField(200, 20, "Game over, please quit using panel above.");
			
			this.message.addChild(tmp);
		}
		
		public function restore():void
		{
			this.message.visible = false;
		}
		
		public function gameOver():void
		{
			this.message.visible = true;	
		}
		
		override public function setUpdateFlow(item:IUpdateDispatcher):void
		{
			super.setUpdateFlow(item);
			
			this.dispatchUpdate(new Update("addToTheHUD", this.message));
		}
	}

}