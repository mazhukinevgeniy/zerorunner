package ui.windows.achievements 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class AchievementItem extends Sprite
	{
		private var _id:int;
		
		private var _position:int;
		
		//TODO: see AchievementBase.as
		
		public function AchievementItem(id:int, position:int, skin:Texture)
		{
			this._id = id;
			this._position = position;
			super();
			
			this.resetSkin(skin);
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
		
		public function get position():int
		{
			return this._position;
		}
		
	}

}