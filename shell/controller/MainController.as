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
		
		private function newGame():void
		{
			(this.game).newGame();
			(this.view).showGame();
			
		}