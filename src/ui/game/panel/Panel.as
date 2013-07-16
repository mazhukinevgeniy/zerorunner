package ui.game.panel 
{
	import chaotic.core.IUpdateDispatcher;
	import flash.display.Stage;
	import flash.geom.Point;
	import game.ZeroRunner;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class Panel extends Sprite
	{
		public static const panel_BackToMenu:String = "panel_BackToMenu";
		public static const panel_RollOut:String = "panel_RollOut";
		public static const panel_RollOver:String = "panel_RollOver";
		
		private var flow:IUpdateDispatcher;
		
		private var body:Sprite;
		
		private var menuButton:Button;
		
		public function Panel(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
			
			this.addChild(new SpaceHolder());
			
			this.body = new Body();
			this.addChild(this.body);
			
			this.addEventListener(Event.TRIGGERED, this.handleTrigger);
			this.addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
			
			this.addButtons();
		}
		
		private function handleAddedToStage():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
			
			this.parent.addEventListener(TouchEvent.TOUCH, this.handleTouch);
		}
		
		private function addButtons():void
		{
			this.menuButton = new Button(Texture.fromColor(100, 20, 0xFFCCFF33), "Quit game");
			this.menuButton.fontName = "HiLo-Deco";
			this.menuButton.fontSize = 18;
			
			this.body.addChild(this.menuButton);
			
			this.menuButton.x = 50 + (Body.HEIGHT - 20) / 2;
			this.menuButton.y = (Body.HEIGHT - 20) / 2;
		}
		
		private function handleTrigger(event:Event):void
		{
			event.stopPropagation();
			
			if (event.target == this.menuButton)
			{
				this.collapse();
				this.flow.dispatchUpdate(Panel.panel_BackToMenu);
				this.flow.dispatchUpdate(ZeroRunner.quitGame);
			}
		}
		
		private function handleTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			
			if (touch && touch.phase == TouchPhase.HOVER)
				this.expand();
			
			else if (this.body.visible)
			{
				var stage:Stage = Starling.current.nativeStage;
				var mouseX:Number = stage.mouseX;
				var mouseY:Number = stage.mouseY;
				if    (mouseX < 0
					|| mouseY < 0
					|| mouseX > Main.WIDTH
					|| mouseY > Body.HEIGHT)
				this.collapse();
			}
		}
		
		public function expand():void
		{
			this.flow.dispatchUpdate(Panel.panel_RollOver);
			this.body.visible = true;
		}
		
		public function collapse():void
		{
			this.flow.dispatchUpdate(Panel.panel_RollOut);
			this.body.visible = false;
		}
	}

}