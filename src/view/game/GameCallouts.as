package view.game 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import model.collectibles.Collectible;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	internal class GameCallouts
	{
		private var gameOrigin:Quad;
		
		private var collectedLabel:Label;
		
		private var currentCallout:Callout;
		private var countdown:int;
		
		public function GameCallouts(binder:IBinder, gameRoot:DisplayObjectContainer) 
		{			
			binder.eventDispatcher.addEventListener(GlobalEvent.QUIT_GAME,
			                                        this.quitGame);
			binder.eventDispatcher.addEventListener(GlobalEvent.COLLECTIBLE_FOUND,
			                                        this.collectibleFound);
			
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
		
		private function collectibleFound(event:Event, collectible:Collectible):void
		{
			if (collectible.unmet)
			{
				if (this.currentCallout)
					throw new Error("can't handle callout overlap");
				else
				{
					this.currentCallout = Callout.show(this.collectedLabel, this.gameOrigin, Callout.DIRECTION_ANY, false);
					this.countdown = View.CALLOUT_LENGTH;
				}
			}
		}
		
		private function quitGame():void
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