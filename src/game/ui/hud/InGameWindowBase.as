package game.ui.hud 
{
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;
	import starling.utils.Color;
	
	internal class InGameWindowBase extends Sprite
	{
		private static const BASE_COLOR:uint = Color.OLIVE;
		
		public function InGameWindowBase(width:int, height:int, atlas:TextureAtlas) 
		{
			this.drawBackground(width, height, atlas);
			
			this.addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
		}
		
		private function drawBackground(width:int, height:int, atlas:TextureAtlas):void
		{
			var border:Image = new Image(atlas.getTexture("vertical-scroll-bar-step-button-down-skin"));
			var pattern:Image = new Image(atlas.getTexture("unimplemented"));
			
			width = width - width % border.width;
			height = height - height % border.height;
			
			var background:QuadBatch = new QuadBatch();
			
			var i:int;
			var j:int;
			
			for (i = 0; i < width; i += pattern.width)
				for (j = 0; j < height; j += pattern.height)
				{
					pattern.x = Math.min(i, width - pattern.width);
					pattern.y = Math.min(j, height - pattern.height);
					
					background.addImage(pattern);
				}
			
			for (i = 0; i < width; i += border.width)
			{
				border.x = i;
				
				border.y = 0;
				background.addImage(border);
				
				border.y = height - border.height;
				background.addImage(border);
			}
			
			for (i = 0; i < height; i += border.height)
			{
				border.y = i;
				
				border.x = 0;
				background.addImage(border);
				
				border.x = width - border.width;
				background.addImage(border);
			}
			
			this.addChild(background);
		}
		
		private function handleAddedToStage():void
		{
			this.x = int((Main.WIDTH - this.width) / 2);
			this.y = int((Main.HEIGHT - this.height) / 2);
		}
	}

}