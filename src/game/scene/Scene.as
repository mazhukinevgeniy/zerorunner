package game.scene 
{
	import flash.utils.ByteArray;
	import game.GameElements;
	import game.interfaces.IRestorable;
	import utils.MapXML;
	
	public class Scene implements IScene, IRestorable
	{
		private var scene:ByteArray;
		
		public function Scene(elements:GameElements) 
		{
			this.scene = new ByteArray();
			
			elements.restorer.addSubscriber(this);
		}
		
		public function restore():void
		{
			this.scene.clear();
			this.scene.length = Game.MAP_WIDTH * Game.MAP_WIDTH;
			
			var map:XML = MapXML.getOne();
			
			if (map.@width != map.@height || map.@width != Game.MAP_WIDTH)
				throw new Error("map is not compatible");
			
			var tileCodes:Array = new Array();
			
			for (var i:int = 0; i < map.tileset.length(); i++)
			{
				var name:String = map.tileset[i].@name;
				
				if (name == "fall")
					tileCodes[i + 1] = Game.SCENE_FALL;
				else if (name == "ground")
					tileCodes[i + 1] = Game.SCENE_GROUND;
				else if (name == "bot_left")
					tileCodes[i + 1] = Game.SCENE_BL_DISK;
				else if (name == "bot_right")
					tileCodes[i + 1] = Game.SCENE_BR_DISK;
				else if (name == "top_left")
					tileCodes[i + 1] = Game.SCENE_TL_DISK;
				else if (name == "top_right")
					tileCodes[i + 1] = Game.SCENE_TR_DISK;
			}
			
			const LENGTH:int = this.scene.length;
			var tiles:XMLList = map.layer.data.tile;
			
			for (var j:int = 0; j < LENGTH; j++)
			{
				this.scene[j] = tileCodes[tiles[j].@gid];
			}
			
			this.validateTheMap();
			
			//TODO: check if we ever need to rerestore the map
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.scene[x + y * Game.MAP_WIDTH];
		}
		
		private function validateTheMap():void
		{
			var possTop:Array = new Array(Game.SCENE_FALL, Game.SCENE_BL_DISK, Game.SCENE_BR_DISK);
			var possBot:Array = new Array(Game.SCENE_FALL, Game.SCENE_TL_DISK, Game.SCENE_TR_DISK);
			var possLef:Array = new Array(Game.SCENE_FALL, Game.SCENE_BR_DISK, Game.SCENE_TR_DISK);
			var possRig:Array = new Array(Game.SCENE_FALL, Game.SCENE_BL_DISK, Game.SCENE_TL_DISK);
			
			const NEGATIVE:String = "Map is invalid at ";			
			var validationError:Error = new Error();
			
			for (var i:int = 0; i < Game.MAP_WIDTH; i++)
				for (var j:int = 0; j < Game.MAP_WIDTH; j++)
				{
					validationError.message = NEGATIVE + i + "," + j;
					
					if (this.getSceneCell(i, j) != Game.SCENE_FALL)
					{
						var _1:int, _2:int, _3:int;
						var _4:int, _5:int, _6:int;
						var _7:int, _8:int, _9:int;
						
						_1 = this.getSceneCell(i - 1, j - 1);
						_2 = this.getSceneCell(i, j - 1);
						_3 = this.getSceneCell(i + 1, j - 1);
						
						_4 = this.getSceneCell(i - 1, j);
						_5 = this.getSceneCell(i, j);
						_6 = this.getSceneCell(i + 1, j);
						
						_7 = this.getSceneCell(i - 1, j + 1);
						_8 = this.getSceneCell(i, j + 1);
						_9 = this.getSceneCell(i + 1, j + 1);
						
						
						if (_5 == Game.SCENE_GROUND)
						{
							var numberOfFallsNearby:int = 0;
							numberOfFallsNearby += int(_2 == Game.SCENE_FALL);
							numberOfFallsNearby += int(_4 == Game.SCENE_FALL);
							numberOfFallsNearby += int(_6 == Game.SCENE_FALL);
							numberOfFallsNearby += int(_8 == Game.SCENE_FALL);
							
							if (numberOfFallsNearby > 1)
								throw validationError;
							else if (numberOfFallsNearby == 1)
							{
								var numberOfBackCornerFalls:int = 0;
								
								if (_2 == Game.SCENE_FALL)
								{
									numberOfBackCornerFalls += int (_7 == Game.SCENE_FALL) + int(_9 == Game.SCENE_FALL);
								}
								else if (_4 == Game.SCENE_FALL)
								{
									numberOfBackCornerFalls += int (_3 == Game.SCENE_FALL) + int(_9 == Game.SCENE_FALL);
								}
								else if (_6 == Game.SCENE_FALL)
								{
									numberOfBackCornerFalls += int (_1 == Game.SCENE_FALL) + int(_7 == Game.SCENE_FALL);
								}
								else if (_8 == Game.SCENE_FALL)
								{
									numberOfBackCornerFalls += int (_1 == Game.SCENE_FALL) + int(_3 == Game.SCENE_FALL);
								}
								
								if (numberOfBackCornerFalls != 0)
									throw validationError;
							}
							else if (numberOfFallsNearby == 0)
							{
								var numberOfFallsAtTheCorner:int = 0;
								numberOfFallsAtTheCorner += int(_1 == Game.SCENE_FALL);
								numberOfFallsAtTheCorner += int(_3 == Game.SCENE_FALL);
								numberOfFallsAtTheCorner += int(_7 == Game.SCENE_FALL);
								numberOfFallsAtTheCorner += int(_9 == Game.SCENE_FALL);
								
								if (numberOfFallsAtTheCorner > 1)
									throw validationError;
							}
						}
						else if (_5 == Game.SCENE_TL_DISK)
						{
							if (possTop.indexOf(_2) == -1 ||
								possLef.indexOf(_4) == -1 ||
								possBot.indexOf(_8) != -1 ||
								possRig.indexOf(_6) != -1)
								throw validationError;
						}
						else if (_5 == Game.SCENE_TR_DISK)
						{
							if (possTop.indexOf(_2) == -1 ||
								possLef.indexOf(_4) != -1 ||
								possBot.indexOf(_8) != -1 ||
								possRig.indexOf(_6) == -1)
								throw validationError;
						}
						else if (_5 == Game.SCENE_BL_DISK)
						{
							if (possTop.indexOf(_2) != -1 ||
								possLef.indexOf(_4) == -1 ||
								possBot.indexOf(_8) == -1 ||
								possRig.indexOf(_6) != -1)
								throw validationError;
						}
						else if (_5 == Game.SCENE_BR_DISK)
						{
							if (possTop.indexOf(_2) != -1 ||
								possLef.indexOf(_4) != -1 ||
								possBot.indexOf(_8) == -1 ||
								possRig.indexOf(_6) == -1)
								throw validationError;
						}
						else throw validationError;
					}
				}
			
			//TODO: remove as soon as the game is done
		}
	}

}