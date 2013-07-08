package controller 
{
	import chaotic.core.ChaoticFeature;
	import chaotic.core.IGame;
	import chaotic.updates.IGameOverHandler;
	import model.IModel;
	import starling.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import view.events.MainMenuEvent;
	import view.events.NavigationEvent;
	import view.events.PanelEvent;
	import view.IView;
	
	public class MainController extends ChaoticFeature implements IGameOverHandler, IController
	{
		private var view:IView;
		private var model:IModel;
		private var game:IGame;
		
		private var pauseToggled:Boolean = true;
		private var isOutOfFocus:Boolean = true;
		private var isOutOfSight:Boolean = true;
		private var isInUse:Boolean = true;
		
		public function MainController(view:IView, model:IModel, game:IGame) 
		{
			super();
			
			(view).setController(this);
			this.view = view;
			this.model = model;
			this.game = game;
			
			(game).addExternalFeature(this);
		}
		
		public function viewPrepared():void
		{
			if ((this.model).settings.mute)
			{
				(this.view).toggleSound();
			}
		}
		
		public function toggleSound():void
		{
			(this.model).settings.toggleMuteOptions();
			(this.view).toggleSound();
		}
		
		public function keyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.M)
			{
				this.toggleSound();
			}
			else if (event.keyCode == Keyboard.P)
			{
				this.pauseToggled = !this.pauseToggled;
				this.setPause();
			}
		}
		
		public function handlePanelEvent(event:PanelEvent):void
		{
			if (event.type == PanelEvent.BACK_TO_MENU)
			{
				this.pauseToggled = true;
				this.isInUse = true;
				this.isOutOfFocus = true;
				this.isOutOfSight = true;
				
				(this.view).hideGame();
			}
			else if (event.type == PanelEvent.ROLL_OUT)
			{
				this.isInUse = false;
				this.setPause();
				
				(this.view).hidePanel();
			}
			else if (event.type == PanelEvent.ROLL_OVER)
			{
				this.isInUse = true;
				this.setPause();
				
				(this.view).showPanel();
			}
		}
		public function handleNavigationEvent(event:NavigationEvent):void
		{
			if (event.type == "Play")
			{
				(this.view).toggleWindow(0);
			}
		}
		public function handleMainMenuEvent(event:MainMenuEvent):void
		{
			if (event.type == MainMenuEvent.NEW_GAME)
			{
				this.newGame();
				(this.view).toggleWindow(0);
			}
			else if (event.type == MainMenuEvent.CLOSE)
			{
				(this.view).toggleWindow(0);
			}
		}
		
		public function keyDown(event:KeyboardEvent):void
		{
			
		}
		
		
		public function focusIn():void
		{
			this.isOutOfFocus = false;
			this.isOutOfSight = false;
			this.setPause();
		}
		public function focusOut():void
		{
			this.isOutOfFocus = true;
			this.setPause();
		}
		
		private function newGame():void
		{
			(this.game).newGame();
			(this.view).showGame();
			
			this.pauseToggled = false;
			this.isInUse = false;
			this.isOutOfFocus = false;
			this.isOutOfSight = false;
			
			this.setPause();
		}
		
		private function setPause():void
		{
			(this.game).setPause(this.pauseToggled || this.isInUse || this.isOutOfFocus || this.isOutOfSight);
		}
		
		public function gameOver():void
		{
			this.pauseToggled = true;
			this.isOutOfFocus = true;
			this.isOutOfSight = true;
			this.isInUse = true;
		}
	}

}