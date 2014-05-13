package view.game.renderer 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import model.utils.normalize;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.extensions.CenteredImage;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
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
		
		private var tiles:XMLList;
		private var tileCodes:Array;
		
		/* Helper variables */
		private var sprites:Vector.<Image>;
		
		private const extraRange:int = 7;
		
		public function SceneRenderer(binder:IBinder, layer:QuadBatch) 
		{
			var assets:AssetManager = binder.assetManager;
			var atlas:TextureAtlas = assets.getTextureAtlas(View.MAIN_ATLAS);
			var offsets:XML = assets.getXml(View.MAIN_OFFSETS);
			
			var key:String;
			
			for each (key in 
					["_1", "_2", "_3", "_4", "_5",
					 "_6", "_7", "_8", "_9",
					 "_11", "_33", "_77", "_99"])
				this[key] = new CenteredImage(atlas.getTexture(key), offsets[key]);
			
			for each (key in 
					["_1", "_2", "_3"])
			{
				this[key + "_"] = new Image(atlas.getTexture(key + "-"));
				this[key + "__"] = new Image(atlas.getTexture(key + "--"));
			}
			
			this.prepareTileCodes();
			
			
			var changes:Changes = new Changes();
			changes._dx = -(View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes.dx = (View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes._dy = -(View.CELLS_IN_VISIBLE_HEIGHT + 1 + 3);
			changes.dy = (View.CELLS_IN_VISIBLE_HEIGHT + 2);
			
			super(binder, layer, changes);
			
			this.sprites = new Vector.<Image>(2, true);
		}
		
		private function prepareTileCodes():void 
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
		}
		
		override protected function renderCell(x:int, y:int):void 
		{
			if (this.getMapCell(x, y) != this.FALL)
			{				
				var tileCode:int = this.getMapCell(x, y);
				
				if (tileCode == this.GROUND)
				{
					var top:int = this.getMapCell(x, y - 1);
					var bot:int = this.getMapCell(x, y + 1);
					var left:int = this.getMapCell(x - 1, y);
					var right:int = this.getMapCell(x + 1, y);
					
					if (top == this.FALL)
						this.sprites[0] = this._8;
					else if (bot == this.FALL)
						this.sprites[0] = this._2;
					else if (left == this.FALL)
						this.sprites[0] = this._4;
					else if (right == this.FALL)
						this.sprites[0] = this._6;
					else if (top == this.TR_DISK || right == this.TR_DISK)
					{
						this.sprites[0] = this._5;
						this.sprites[1] = this._99;
					}
					else if (top == this.TL_DISK || left == this.TL_DISK)
					{
						this.sprites[0] = this._5;
						this.sprites[1] = this._77;
					}
					else if (bot == this.BL_DISK || left == this.BL_DISK)
					{
						this.sprites[0] = this._5;
						this.sprites[1] = this._11;
					}
					else if (bot == this.BR_DISK || right == this.BR_DISK)
					{
						this.sprites[0] = this._5;
						this.sprites[1] = this._33;
					}
					else
						this.sprites[0] = this._5;
				}
				else if (tileCode == this.BL_DISK)
					this.sprites[0] = this._1;
				else if (tileCode == this.TL_DISK)
					this.sprites[0] = this._7;
				else if (tileCode == this.BR_DISK)
					this.sprites[0] = this._3;
				else if (tileCode == this.TR_DISK)
					this.sprites[0] = this._9;
				
				var sprite:Image;
				
				for (var i:int = 0; i < 2; i++)
				{
					sprite = this.sprites[i];
					
					if (sprite)
					{
						sprite.x = x * View.CELL_WIDTH;
						sprite.y = y * View.CELL_HEIGHT;
						
						this.layer.addImage(sprite);
					}
				}
				
				this.sprites[0] = null;
				this.sprites[1] = null;
				
				
				var name:String = "";
				
				if (sprite == this._1)
					name = "_1";
				else if (sprite == this._2)
					name = "_2";
				else if (sprite == this._3)
					name = "_3";
				
				if (name != "")
				{
					for (var iI:int = 1; iI < 4; iI++)
					{
						var isTitle:String = name + "_" + (iI == 3 ? "_" : "");
						
						sprite = this[isTitle];
						
						sprite.x = x * View.CELL_WIDTH;
						sprite.y = (y + iI) * View.CELL_HEIGHT;
						
						this.layer.addImage(sprite);
					}
				}
			}
		}
		
		private function getMapCell(x:int, y:int):int
		{
			var key:int = normalize(x) + normalize(y) * Game.MAP_WIDTH;
			
			return this.tileCodes[this.tiles[key].@gid];
		}
	}

}