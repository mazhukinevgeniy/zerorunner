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
		public static const addToTheHUD:String = "addToTheHUD";
		
		public static const prerestore:String = "prerestore"; //TODO: check if required
		public static const restore:String = "restore";
		
		public static const gameOver:String = "gameOver";
		public static const quitGame:String = "quitGame";
		
		public static const setGameContainer:String = "setGameContainer";
		
		
		
		protected var displayRoot:Sprite;
		
		public function UpdateGameBase(flowName:String) 
		{
			super(flowName);
			
			this.workWithUpdateListener(this);
			this.addUpdateListener(ChaoticUI.newGame);
			this.addUpdateListener(UpdateGameBase.addToTheHUD);
			this.addUpdateListener(UpdateGameBase.quitGame);
			this.addUpdateListener(UpdateGameBase.setGameContainer);
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
			this.dispatchUpdate(UpdateGameBase.prerestore);
			this.dispatchUpdate(UpdateGameBase.restore);
		}
		
		update function quitGame():void
		{
			this.dispatchUpdate(UpdateManager.callExternalFlow, ChaoticUI.flowName, UpdateGameBase.quitGame);
		}
		
		final update function addToTheHUD(item:DisplayObject):void
		{
			this.displayRoot.addChild(item);
		}
	}

}