package utils.templates 
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.errors.AbstractClassError;
	import ui.ChaoticUI;
	import utils.updates.update;
	import utils.updates.UpdateManager;
	
	public class UpdateGameBase extends UpdateManager
	{
		protected var displayRoot:Sprite;
		
		public function UpdateGameBase(flowName:String) 
		{
			super(flowName);
			
			this.workWithUpdateListener(this);
			this.addUpdateListener(Update.newGame);
			this.addUpdateListener(Update.addToTheHUD);
			this.addUpdateListener(Update.quitGame);
			this.addUpdateListener(Update.setGameContainer);
		}
		
		final update function setGameContainer(viewRoot:Sprite):void
		{
			this.displayRoot = viewRoot;
			
			this.initializeFeatures();
		}
		
		protected function initializeFeatures():void
		{
			throw new AbstractClassError();
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