package view.game.renderer.scene 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import starling.display.Image;
	import starling.extensions.CenteredImage;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.getCellId;
	import view.game.renderer.structs.Changes;
	import view.game.renderer.SubRendererBase;
	
	public class SceneRenderer extends SubRendererBase
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
		
		private var _1_mid:Image, _1_bot:Image;
		private var _2_mid:Image, _2_bot:Image;
		private var _3_mid:Image, _3_bot:Image;
		
		private var tiles:XMLList;
		private var tileCodes:Array;
		
		/* Helper variables */
		private var sprites:Vector.<Image>;
		
		private const extraRange:int = 7;
		
		public function SceneRenderer(binder:IBinder) 
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
					["_1_", "_2_", "_3_"])
			{
				for each (var postfix:String in ["mid", "bot"])
				{
					var name:String = key + postfix;
					this[name] = new CenteredImage(atlas.getTexture(name), offsets[name]);
				}
			}
			
			this.prepareTileCodes();
			
			
			var changes:Changes = new Changes();
			changes._dx = -(View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes.dx = (View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes._dy = -(View.CELLS_IN_VISIBLE_HEIGHT + 1 + 3);
			changes.dy = (View.CELLS_IN_VISIBLE_HEIGHT + 2);
			
			super(binder, changes);
			
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
			var tileCode:int = this.getMapCell(x, y);
			
			if (tileCode != this.FALL)
			{				
				
				if (tileCode == this.GROUND)
				{
					var top:int = this.getMapCell(x, y - 1);
					var bot:int = this.getMapCell(x, y + 1);
					var left:int = this.getMapCell(x - 1, y);
					var right:int = this.getMapCell(x + 1, y);
					
					if (top == this.FALL)
					{
						this.sprites[0] = this._8;
					}
					else if (bot == this.FALL)
					{
						this.sprites[0] = this._2;
					}
					else if (left == this.FALL)
					{
						top = this.getMapCell(x - 1, y - 1);
						
						if (top == this.GROUND || top == this.BL_DISK)
							this.sprites[0] = this._2_mid;
						else 
						{
							top = this.getMapCell(x - 1, y - 2);
						    
							if (top == this.GROUND || top == this.BL_DISK)
								this.sprites[0] = this._2_mid;
						}
						
						this.sprites[1] = this._4;
					}
					else if (right == this.FALL)
					{
						top = this.getMapCell(x + 1, y - 1);
						
						if (top == this.GROUND || top == this.BR_DISK)
							this.sprites[0] = this._2_mid;
						else 
						{
							top = this.getMapCell(x + 1, y - 2);
						    
							if (top == this.GROUND || top == this.BR_DISK)
								this.sprites[0] = this._2_mid;
						}
						
						this.sprites[1] = this._6;
					}
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
						
						this.addImage(sprite);
					}
				}
				
				
				var name:String = "";
				
				if (this.sprites[0] == this._1)
					name = "_1";
				else if (this.sprites[0] == this._2)
					name = "_2";
				else if (this.sprites[0] == this._3)
					name = "_3";
				
				if (name != "")
				{
					var imid:Image = this[name + "_mid"];
					
					imid.x = x * View.CELL_WIDTH;
					imid.y = (y + 1) * View.CELL_HEIGHT;
					
					this.addImage(imid);
					
					var ibot:Image = this[name + "_bot"];
					
					ibot.x = x * View.CELL_WIDTH;
					ibot.y = (y + 2) * View.CELL_HEIGHT;
					
					this.addImage(ibot);
				}
				
				
				this.sprites[0] = null;
				this.sprites[1] = null;
			}
		}
		
		private function getMapCell(x:int, y:int):int
		{
			return this.tileCodes[this.tiles[getCellId(x, y)].@gid];
		}
	}

}