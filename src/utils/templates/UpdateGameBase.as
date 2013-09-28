package utils.templates 
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.errors.AbstractClassError;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	final public class UpdateGameBase
	{
		private var displayRoot:Sprite;
		
		private var flow:IUpdateDispatcher;
		
		public function UpdateGameBase(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.addToTheHUD);
			flow.addUpdateListener(Update.setGameContainer);
		}
		
		final update function setGameContainer(viewRoot:Sprite):void
		{
			this.displayRoot = viewRoot;
			this.displayRoot.stage.color = 0;
		}
		
		
		update function newGame():void
		{
			this.flow.dispatchUpdate(Update.prerestore);
			this.flow.dispatchUpdate(Update.restore);
		}
		
		final update function addToTheHUD(item:DisplayObject):void
		{
			this.displayRoot.addChild(item);
		}
	}

}