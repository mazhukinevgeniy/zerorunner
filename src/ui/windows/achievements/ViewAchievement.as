package ui.windows.achievements 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	internal class ViewAchievement extends Sprite
	{
		private var _id:int;
		
		private var position:int;
		
		public function ViewAchievement(id:int, position:int, skin:Texture)
		{
			this._id = id;
			this.position = position;
			
			super();
			
			this.resetSkin(skin);
			this.locate();
		}
		
		private function locate():void
		{
			trace(HexagonalGrid.NUMBER_OF_CELL_IN_WIDTH);
			var xOfCell:int = this.position % HexagonalGrid.NUMBER_OF_CELL_IN_WIDTH;
			var yOfCell:int = (int)(this.position / HexagonalGrid.NUMBER_OF_CELL_IN_WIDTH);
			
			this.x = HexagonalGrid.OFFSET_X + (0.5 + xOfCell * 0.75) * HexagonalGrid.HEXAGONAL_WIDTH - this.width / 2;
			this.y = HexagonalGrid.OFFSET_Y + (yOfCell + 0.5) * HexagonalGrid.HEXAGONAL_HEIGHT - this.height / 2;
			
			if (xOfCell % 2 == 1)
				this.y += 0.5 * HexagonalGrid.HEXAGONAL_HEIGHT;
			
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