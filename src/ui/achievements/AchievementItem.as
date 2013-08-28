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
		
		//TODO: see AchievementBase.as
		
		public function AchievementItem() 
		{
			this.enableSkin = new Image(Texture.fromColor(2 * AchievmentItem.RADIUS, 2 * AchievmentItem.RADIUS, 0x56723412));
			this.disableSkin = new Image(Texture.fromColor(2 * AchievmentItem.RADIUS, 2 * AchievmentItem.RADIUS, 0x01928374));
			
			super();
			this.skin = this.disableSkin;
			this.addChild(this.skin);
		}
		
		public function unlock():void
		{
			this.skin = this.enableSkin();
		}
		
	}

}