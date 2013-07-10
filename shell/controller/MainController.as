		public function toggleSound():void
		{
			(this.model).settings.toggleMuteOptions();
			(this.view).toggleSound();
		}
		
		
		
		public function handlePanelEvent(event:PanelEvent):void
		{
			if (event.type == PanelEvent.BACK_TO_MENU)
			{
				
				
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