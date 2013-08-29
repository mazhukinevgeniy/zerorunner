package utils.templates 
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.errors.AbstractClassError;
	import ui.ChaoticUI;
	import utils.updates.update;
	import utils.updates.UpdateManager;
	
	final public class UpdateGameBase extends UpdateManager
	{
		public static const flowName:String = "Game Flow";
		
		private var displayRoot:Sprite;
		
		public function UpdateGameBase() 
		{
			super(UpdateGameBase.flowName);
			
			this.workWithUpdateListener(this);
			this.addUpdateListener(Update.newGame);
			this.addUpdateListener(Update.addToTheHUD);
			this.addUpdateListener(Update.quitGame);
			this.addUpdateListener(Update.setGameContainer);
		}
		
		final update function setGameContainer(viewRoot:Sprite):void
		{
			this.displayRoot = viewRoot;
			this.displayRoot.stage.color = 0;
		}
		
		
		update function newGame():void
		{
			this.dispatchUpdate(Update.prerestore);
			this.dispatchUpdate(Update.restore);
		}
		
		update function quitGame():void
		{
			this.dispatchUpdate(UpdateManager.callExternalFlow, ChaoticUI.flowName, Update.quitGame);
		}
		
		final update function addToTheHUD(item:DisplayObject):void
		{
			this.displayRoot.addChild(item);
		}
	}

}