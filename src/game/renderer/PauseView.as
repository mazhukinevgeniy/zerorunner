package game.renderer 
{
	import data.viewers.GameConfig;
	import starling.display.Sprite;
	import starling.text.TextField;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class PauseView extends Sprite
	{
		private var notification:TextField;
		
		public function PauseView(flow:IUpdateDispatcher) 
		{
			super();
			
			this.notification = new TextField(500, 40, "Game paused", "HiLo-Deco", 30);
			this.addChild(this.notification);
			
			this.notification.y += 50;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.restore);
			flow.addUpdateListener(Update.timeFixed);
		}
		
		update function restore(config:GameConfig):void
		{
			this.visible = false;
		}
		
		update function timeFixed(isFixed:Boolean):void
		{
			this.visible = isFixed;
		}
	}

}