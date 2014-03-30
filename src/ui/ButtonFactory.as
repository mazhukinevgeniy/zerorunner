package ui 
{
	import feathers.controls.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class ButtonFactory 
	{
		private var defaultWidth:Number,
					defaultHeight:Number;
					
		private var background:String;
		
		public function ButtonFactory(assets:AssetManager, defaultWidth:Number, defaultHeight:Number)
		{
					this.defaultHeight = defaultHeight;
					this.defaultWidth = defaultWidth;
					this.background = background;
		}
		
		public function createButton(title:String, background:String = null):Button
		{
				var button:Button = new Button();
				
				button.width = this.defaultWidth;
				button.height = this.defaultHeight;
				button.
				
				if (background != null)
				{
					var texture:Texture = new Texture();
					var image:Image;
					
					texture = this.assets.getTextureAtlas("sprites").getTexture(background);
					image = new Image(texture);
					button.defaultSkin = image;
				}
		}
		
	}

}