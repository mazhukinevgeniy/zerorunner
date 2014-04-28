package game.renderer 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	import utils.MapXML;
	
	internal class SceneRenderer extends SubRendererBase
	{
		private const FALL:int = 0;
		private const TL_DISK:int = 1;
		private const TR_DISK:int = 2;
		private const BL_DISK:int = 3;
		private const BR_DISK:int = 4;
		private const GROUND:int = 5;
		
		private var _5:Image;
		private var _6:Image, _8:Image, _4:Image, _2:Image;
		private var _3:Image, _9:Image, _7:Image, _1:Image;
		private var _33:Image, _99:Image, _77:Image, _11:Image;
		
		private var _1_:Image, _1__:Image, _2_:Image, _2__:Image, _3_:Image, _3__:Image;
		
		/* Helper variables */
		private var tiles:XMLList;
		private var tileCodes:Array;
		
		private const extraRange:int = 7;
		
		public function SceneRenderer(elements:GameElements) 
		{
			super(elements);
			
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
			var map:XML = MapXML.getOne();
			this.tiles = map.layer.data.tile;
			
			this.tileCodes = new Array();
			
			for (var i:int = 0; i < map.tileset.length(); i++)
			{
				var name:String = map.tileset[i].@name;
				
				if (name == "fall")
					this.tileCodes[i + 1] = this.FALL;
				else if (name == "ground")
					this.tileCodes[i + 1] = this.GROUND;
				else if (name == "bot_left")
					this.tileCodes[i + 1] = this.BL_DISK;
				else if (name == "bot_right")
					this.tileCodes[i + 1] = this.BR_DISK;
				else if (name == "top_left")
					this.tileCodes[i + 1] = this.TL_DISK;
				else if (name == "top_right")
					this.tileCodes[i + 1] = this.TR_DISK;
			}
			//TODO: get rid of nonfunctional tr_disk global scene types
		}
		
		override protected function get range():int 
		{
			return 7;
			//TODO: determine range softer
		}
		
		override protected function renderCell(x:int, y:int, frame:int):void 
		{
			if (this.getMapCell(x, y) != this.FALL)
			{
				var sTitle:String;
				
				var tileCode:int = this.getMapCell(x, y);
				
				if (tileCode == this.GROUND)
				{
					if (this.getMapCell(x, y - 1) == this.FALL)
						sTitle = "_8";
					else if (this.getMapCell(x, y + 1) == this.FALL)
						sTitle = "_2";
					else if (this.getMapCell(x - 1, y) == this.FALL)
						sTitle = "_4";
					else if (this.getMapCell(x + 1, y) == this.FALL)
						sTitle = "_6";
					else if (this.getMapCell(x - 1, y - 1) == this.FALL)
						sTitle = "_77";
					else if (this.getMapCell(x + 1, y - 1) == this.FALL)
						sTitle = "_99";
					else if (this.getMapCell(x - 1, y + 1) == this.FALL)
						sTitle = "_11";
					else if (this.getMapCell(x + 1, y + 1) == this.FALL)
						sTitle = "_33";
					else
						sTitle = "_5";
				}
				else if (tileCode == this.BL_DISK)
					sTitle = "_1";
				else if (tileCode == this.TL_DISK)
					sTitle = "_7";
				else if (tileCode == this.BR_DISK)
					sTitle = "_3";
				else if (tileCode == this.TR_DISK)
					sTitle = "_9";
				
				var sprite:Image = this[sTitle];
				
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
		
		private function getMapCell(x:int, y:int):int
		{
			var key:int = normalize(x) + normalize(y) * Game.MAP_WIDTH;
			
			return this.tileCodes[this.tiles[key].@gid];
		}
		
		override protected function checkIfShouldRender(frame:int):Boolean 
		{
			return frame == Game.FRAME_TO_ACT;
		}
	}

}