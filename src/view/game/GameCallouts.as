package view.game 
{
	import binding.IBinder;
	import controller.observers.ICollectibleObserver;
	import controller.observers.IQuitGameHandler;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import model.collectibles.Collectible;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	
	internal class GameCallouts implements ICollectibleObserver,
										   IQuitGameHandler
	{
		private var gameOrigin:Quad;
		
		private var collectedLabel:Label;
		
		private var currentCallout:Callout;
		private var countdown:int;
		
		public function GameCallouts(binder:IBinder, gameRoot:DisplayObjectContainer) 
		{			
			binder.notifier.addObserver(this);
			
			this.collectedLabel = new Label();
			this.collectedLabel.text = "NEW COLLECTIBLE";
			
			this.gameOrigin = new Quad(1, 1, 0x000000);
			this.gameOrigin.visible = false;
			this.gameOrigin.x = View.WIDTH * 6 / 7;
			this.gameOrigin.y = View.HEIGHT;
			
			gameRoot.addChild(this.gameOrigin);
			
			gameRoot.addEventListener(
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
		
		public function quitGame():void
		{
			if (this.currentCallout)
				this.currentCallout.close();
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