package ui.achievements 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class AchievementItem extends Sprite
	{
		
		private static const RADIUS:Number = 15;
		
		private var enableSkin:Image;
		private var disableSkin:Image;
		private var skin:Image;
		
		private var xCell:Number;
		private var yCell:Number;
		private var tableLocks:AchievementsTable;
		
		//TODO: see AchievementBase.as
		
		public function AchievementItem(tableLocks:AchievementsTable, xCell:Number = 0, yCell:Number = 0) 
		{
			this.enableSkin = new Image(Texture.fromColor(2 * AchievementItem.RADIUS, 2 * AchievementItem.RADIUS, 0x56723412));
			this.disableSkin = new Image(Texture.fromColor(2 * AchievementItem.RADIUS, 2 * AchievementItem.RADIUS, 0x01928374));
			
			super();
			this.xCell = xCell;
			this.yCell = yCell;
			this.tableLocks = tableLocks;
			this.resetSkin();
			this.addChild(this.skin);
		}
		
		public function unlock():void
		{
			this.tableLocks.setCell(this.xCell, this.yCell);
			this.resetSkin();
		}
		
		private function resetSkin():void
		{
			if (this.tableLocks.getCell(this.xCell, this.yCell))
				this.skin = this.disableSkin;
			else
				this.skin = this.enableSkin;
		}
		
	}

}