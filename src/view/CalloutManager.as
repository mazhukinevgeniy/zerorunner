package view 
{
	import binding.IBinder;
	import controller.observers.ICollectibleObserver;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.core.PopUpManager;
	import model.collectibles.Collectible;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	
	internal class CalloutManager implements ICollectibleObserver,
	                                         INewGameHandler,
											 IQuitGameHandler
	{
		private var gameRoot:DisplayObjectContainer;
		private var shellRoot:DisplayObjectContainer;
		
		private var gameOrigin:DisplayObject;
		
		private var collectedLabel:Label;
		
		private var currentCallout:Callout;
		private var countdown:int;
		
		public function CalloutManager(binder:IBinder, 
		                               shellRoot:DisplayObjectContainer, 
									   gameRoot:DisplayObjectContainer) 
		{
			this.gameRoot = gameRoot;
			this.shellRoot = shellRoot;
			
			binder.notifier.addObserver(this);
			
			PopUpManager.root = shellRoot;
			
			this.collectedLabel = new Label();
			this.collectedLabel.text = "NEW COLLECTIBLE";
			
			this.gameOrigin = new Quad(1, 1, 0x000000);
			this.gameOrigin.visible = false;
			this.gameOrigin.x = View.WIDTH * 6 / 7;
			this.gameOrigin.y = View.HEIGHT;
			
			this.gameRoot.addChild(this.gameOrigin);
			
			Callout.stagePaddingBottom = Callout.stagePaddingLeft =
				Callout.stagePaddingRight = Callout.stagePaddingTop = 10;
			
			this.gameRoot.parent.addEventListener(
				EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
		}
		
		public function setCollectibleFound(collectible:Collectible):void
		{
			if (collectible.unmet)
			{
				if (this.currentCallout)
					throw new Error("can't handle callout overlap");
				else
				{
					this.currentCallout = Callout.show(this.collectedLabel, this.gameOrigin);
					this.countdown = View.CALLOUT_LENGTH;
				}
			}
		}
		
		public function newGame():void
		{
			PopUpManager.root = this.gameRoot;
			
			this.countdown = View.CALLOUT_LENGTH;
		}
		
		public function quitGame():void
		{
			PopUpManager.root = this.shellRoot;
			if (this.currentCallout)
				this.currentCallout.close();
			
			this.countdown = View.CALLOUT_LENGTH;
		}
		
		private function handleEnterFrame():void
		{
			if (this.currentCallout)
			{
				this.countdown--;
				
				if (this.countdown < 0)
				{
					this.currentCallout.close();
					
					this.currentCallout = null;
				}
			}
		}
	}

}