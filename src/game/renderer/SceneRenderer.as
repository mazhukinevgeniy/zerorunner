package game.renderer 
{
	import game.GameElements;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import game.scene.IScene;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.TextureAtlas;
	import utils.updates.update;
	
	internal class SceneRenderer extends QuadBatch
	{
		private var _5:Image;
		private var _6:Image, _8:Image, _4:Image, _2:Image;
		private var _3:Image, _9:Image, _7:Image, _1:Image;
		private var _33:Image, _99:Image, _77:Image, _11:Image;
		
		private var xM:int = 1 + Math.random() * 5;
		private var yM:int = 1 + Math.random() * 5;
		
		private var scene:IScene;
		
		private var center:ICoordinated;
		private var previousCenter:CellXY;
		
		public function SceneRenderer(elements:GameElements) 
		{
			super();
			
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			
			this.scene = elements.scene;
			
			
			var atlas:TextureAtlas = elements.assets.getTextureAtlas("sprites");
			
			for each (var key:String in 
					["1", "2", "3", "4", "5",
					 "6", "7", "8", "9",
					 "11", "33", "77", "99"])
				this["_" + key] = new Image(atlas.getTexture(key));
			
			
			this.previousCenter = new CellXY(-1, -1);
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.xM = 1 + Math.random() * 5;
			this.yM = 1 + Math.random() * 5;
			
			this.previousCenter.setValue( -1, -1);
			
			this.center = center;
		}
		
		update function numberedFrame(key:int):void
		{
			if (!this.previousCenter.isEqualTo(this.center))
			{
				this.redraw();
				
				this.previousCenter.setValue(this.center.x, this.center.y);
			}
		}
		
		update function quitGame():void
		{
			this.reset();
		}
		
		private function redraw():void
		{
			this.reset();
			
			const tlcX:int = this.center.x - 10;
			const tlcY:int = this.center.y - 8;
			
			const brcX:int = this.center.x + 11;
			const brcY:int = this.center.y + 9;
			
			var sprite:Image;
			
			var i:int;
			var j:int;
			
			var up:Boolean, down:Boolean, right:Boolean, left:Boolean;
			var numberOfBorders:int;
			
			var sTitle:String;
			
			var tileCode:int;
			
			for (j = tlcY; j < brcY; j++)
			{
				for (i = tlcX; i < brcX; i++)
				{
					if (this.scene.getSceneCell(i, j) != Game.SCENE_FALL)
					{
						up = this.scene.getSceneCell(i, j - 1) == Game.SCENE_FALL;
						down = this.scene.getSceneCell(i, j + 1) == Game.SCENE_FALL;
						right = this.scene.getSceneCell(i + 1, j) == Game.SCENE_FALL;
						left = this.scene.getSceneCell(i - 1, j) == Game.SCENE_FALL;
						
						numberOfBorders = int(up) + int(down) + int(left) + int(right);
						
						if (this.scene.getSceneCell(i, j) == Game.SCENE_GROUND)
						{
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
							else if (numberOfBorders == 0)
								sTitle = "_5";
							else if (up)
								sTitle = "_8";
							else if (down)
								sTitle = "_2";
							else if (left)
								sTitle = "_4";
							else if (right)
								sTitle = "_6";
							else throw new Error();
						}
						else
						{
							//it must be disk then
							tileCode = this.scene.getSceneCell(i, j);
							
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
						
						sprite.x = i * Game.CELL_WIDTH;
						sprite.y = j * Game.CELL_HEIGHT;
						
						this.addImage(sprite);
					}
						 //TODO: don't get i,j so often
						 //TODO: what if we have our own cache? seems semilegit
						 
						 //TODO: add 1-, 2-, 3-
				}
				
			}
		}
		
	}

}