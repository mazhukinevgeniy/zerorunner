package ui.windows.achievements 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	internal class ViewAchievement extends Sprite
	{
		private var _id:int;
		private var position:int;
		
		private var parentContainer:AchievementsWindow;
		
		internal var data:AchievementData;
		
		public function ViewAchievement(id:int, position:int, skin:Texture, parentContainer:AchievementsWindow)
		{
			this._id = id;
			this.position = position;
			this.parentContainer = parentContainer;
			
			//this. //TODO: what was that?
			
			super();
			
			this.resetSkin(skin);
			this.locate();
			
			this.addEventListener(TouchEvent.TOUCH, this.handleContainerTouch);
		}
		
		private function locate():void
		{
			var xOfCell:int = this.position % HexagonalGrid.NUMBER_OF_CELL_IN_WIDTH;
			var yOfCell:int = (int)(this.position / HexagonalGrid.NUMBER_OF_CELL_IN_WIDTH);
			
			this.x = HexagonalGrid.OFFSET_X + (0.5 + xOfCell * 0.75) * HexagonalGrid.HEXAGONAL_WIDTH - this.width / 2;
			this.y = HexagonalGrid.OFFSET_Y + (yOfCell + 0.5) * HexagonalGrid.HEXAGONAL_HEIGHT - this.height / 2;
			
			if (xOfCell % 2 == 1)
				this.y += 0.5 * HexagonalGrid.HEXAGONAL_HEIGHT;
			
		}
		
		private function handleContainerTouch(event:TouchEvent):void
		{
			var touchHover:Touch = event.getTouch(this, TouchPhase.HOVER)
			
			if (touchHover)
			{
				this.parentContainer.displayDescription(this.id);
			}	
		}
		
		public function resetSkin(newSkin:Texture):void
		{
			this.removeChildren();
			this.addChild(new Image(newSkin));
		}
		
		public function get id():int
		{
			return this._id;
		}

		
	}

}