package game.renderer 
{
	import game.GameElements;
	import game.scene.IScene;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	
	internal class SceneRenderer extends SubRendererBase
	{
		private var _5:Image;
		private var _6:Image, _8:Image, _4:Image, _2:Image;
		private var _3:Image, _9:Image, _7:Image, _1:Image;
		private var _33:Image, _99:Image, _77:Image, _11:Image;
		
		private var _1_:Image, _1__:Image, _2_:Image, _2__:Image, _3_:Image, _3__:Image;
		
		private var xM:int = 1 + Math.random() * 5;
		private var yM:int = 1 + Math.random() * 5;
		
		private var scene:IScene;
		
		public function SceneRenderer(elements:GameElements) 
		{
			super(elements);
			
			this.scene = elements.scene;
			
			var atlas:TextureAtlas = elements.assets.getTextureAtlas("sprites");
			
			var key:String;
			
			for each (key in 
					["1", "2", "3", "4", "5",
					 "6", "7", "8", "9",
					 "11", "33", "77", "99"])
				this["_" + key] = new Image(atlas.getTexture(key));
			
			for each (key in 
					["1", "2", "3"])
			{
				this["_" + key + "_"] = new Image(atlas.getTexture(key + "-"));
				this["_" + key + "__"] = new Image(atlas.getTexture(key + "--"));
			}
		}
		
		override protected function handleGameStarted():void 
		{
			this.xM = 1 + Math.random() * 5;
			this.yM = 1 + Math.random() * 5;
		}
		
		override protected function renderCell(x:int, y:int, frame:int):void 
		{
			if (this.scene.getSceneCell(x, y) != Game.SCENE_FALL)
			{
				var sprite:Image;
				
				var up:Boolean, down:Boolean, right:Boolean, left:Boolean;
				var numberOfBorders:int;
				
				var sTitle:String;
				
				var tileCode:int;
				
				
				if (this.scene.getSceneCell(x, y) == Game.SCENE_GROUND)
				{
					up = this.scene.getSceneCell(x, y - 1) == Game.SCENE_FALL;
					down = this.scene.getSceneCell(x, y + 1) == Game.SCENE_FALL;
					right = this.scene.getSceneCell(x + 1, y) == Game.SCENE_FALL;
					left = this.scene.getSceneCell(x - 1, y) == Game.SCENE_FALL;
					
					numberOfBorders = int(up) + int(down) + int(left) + int(right);
					
					if (numberOfBorders > 1)
						throw new Error();
					else if (numberOfBorders == 1)
					{
						if (up)
							sTitle = "_8";
						else if (down)
							sTitle = "_2";
						else if (left)
							sTitle = "_4";
						else if (right)
							sTitle = "_6";
						else throw new Error();
					}
					else if (numberOfBorders == 0)
					{
						up = this.scene.getSceneCell(x, y - 1) != Game.SCENE_GROUND;
						down = this.scene.getSceneCell(x, y + 1) != Game.SCENE_GROUND;
						right = this.scene.getSceneCell(x + 1, y) != Game.SCENE_GROUND;
						left = this.scene.getSceneCell(x - 1, y) != Game.SCENE_GROUND;
						
						numberOfBorders = int(up) + int(down) + int(left) + int(right);
						
						if (numberOfBorders > 2)
							throw new Error();
						else if (numberOfBorders == 2)
						{
							if (up)
							{
								if (right)
									sTitle = "_99";
								else if (left)
									sTitle = "_77";
								else throw new Error();
							}
							else if (down)
							{
								if (right)
									sTitle = "_33";
								else if (left)
									sTitle = "_11";
								else throw new Error();
							}
							else throw new Error();
						}
						else sTitle = "_5";
					}
				}
				else
				{
					//it must be disk then
					tileCode = this.scene.getSceneCell(x, y);
					
					if (tileCode == Game.SCENE_BL_DISK)
						sTitle = "_1";
					else if (tileCode == Game.SCENE_TL_DISK)
						sTitle = "_7";
					else if (tileCode == Game.SCENE_BR_DISK)
						sTitle = "_3";
					else if (tileCode == Game.SCENE_TR_DISK)
						sTitle = "_9";
					else throw new Error();
				}
				
				sprite = this[sTitle];
				
				sprite.x = x * Game.CELL_WIDTH;
				sprite.y = y * Game.CELL_HEIGHT;
				
				this.addImage(sprite);
				
				if (sprite == this._1 || sprite == this._2 || sprite == this._3)
				{
					for (var iI:int = 1; iI < 4; iI++)
					{
						var isTitle:String = sTitle + "_" + (iI == 3 ? "_" : "");
						
						sprite = this[isTitle];
						
						sprite.x = x * Game.CELL_WIDTH;
						sprite.y = (y + iI) * Game.CELL_HEIGHT;
						
						this.addImage(sprite);
					}
				}
			}
		}
		
		override protected function get range():int 
		{
			return 6; 
			//TODO: use xrange and yrange
		}
		
		override protected function checkIfShouldRender(frame:int):Boolean 
		{
			return frame == Game.FRAME_TO_ACT;
		}
	}

}