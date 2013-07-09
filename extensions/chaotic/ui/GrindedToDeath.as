package chaotic.ui 
{
	import chaotic.informers.IGiveInformers;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.updates.IUpdateListener;
	import chaotic.updates.IUpdateListenerAdder;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class GrindedToDeath implements IUpdateListener
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
		
		public function addListenersTo(storage:IUpdateListenerAdder):void
		{
			storage.addUpdateListener(this, "restore");
			storage.addUpdateListener(this, "gameOver");
			storage.addUpdateListener(this, "getInformerFrom");
		}
		
		public function restore():void
		{
			this.message.visible = false;
		}
		
		public function gameOver():void
		{
			this.message.visible = true;	
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			table.getInformer(IUpdateDispatcher).dispatchUpdate("addToTheHUD", this.message);
		}
	}

}