package assets 
{
	import assets.xml.MapXML;
	import utils.getCellId;
	
	internal function validateTheMap():void
	{
		var map:XML = MapXML.getOne();
		
		const SCENE_FALL:int = 0;
		const SCENE_GROUND:int = 1;
		const SCENE_BL_DISK:int = 2;
		const SCENE_BR_DISK:int = 3;
		const SCENE_TL_DISK:int = 4;
		const SCENE_TR_DISK:int = 5;
		
		var tileCodes:Array = getTileCodes();
		
		const NEGATIVE:String = "Map is invalid at ";			
		var validationError:Error = new Error();
		
		var tiles:XMLList = map.layer.data.tile;
		
		var possTop:Array = new Array(SCENE_FALL, SCENE_BL_DISK, SCENE_BR_DISK);
		var possBot:Array = new Array(SCENE_FALL, SCENE_TL_DISK, SCENE_TR_DISK);
		var possLef:Array = new Array(SCENE_FALL, SCENE_BR_DISK, SCENE_TR_DISK);
		var possRig:Array = new Array(SCENE_FALL, SCENE_BL_DISK, SCENE_TL_DISK);
		
		for (var i:int = 0; i < Game.MAP_WIDTH; i++)
			for (var j:int = 0; j < Game.MAP_WIDTH; j++)
			{
				validationError.message = NEGATIVE + i + "," + j;
				
				if (getSceneCell(i, j) != SCENE_FALL)
				{
					var _1:int, _2:int, _3:int;
					var _4:int, _5:int, _6:int;
					var _7:int, _8:int, _9:int;
					
					_1 = getSceneCell(i - 1, j - 1);
					_2 = getSceneCell(i, j - 1);
					_3 = getSceneCell(i + 1, j - 1);
					
					_4 = getSceneCell(i - 1, j);
					_5 = getSceneCell(i, j);
					_6 = getSceneCell(i + 1, j);
					
					_7 = getSceneCell(i - 1, j + 1);
					_8 = getSceneCell(i, j + 1);
					_9 = getSceneCell(i + 1, j + 1);
					
					
					if (_5 == SCENE_GROUND)
					{
						var numberOfFallsNearby:int = 0;
						numberOfFallsNearby += int(_2 == SCENE_FALL);
						numberOfFallsNearby += int(_4 == SCENE_FALL);
						numberOfFallsNearby += int(_6 == SCENE_FALL);
						numberOfFallsNearby += int(_8 == SCENE_FALL);
						
						if (numberOfFallsNearby > 1)
							throw validationError;
						else if (numberOfFallsNearby == 1)
						{
							var numberOfBackCornerFalls:int = 0;
							
							if (_2 == SCENE_FALL)
							{
								numberOfBackCornerFalls += int(_7 == SCENE_FALL) + int(_9 == SCENE_FALL);
							}
							else if (_4 == SCENE_FALL)
							{
								numberOfBackCornerFalls += int(_3 == SCENE_FALL) + int(_9 == SCENE_FALL);
							}
							else if (_6 == SCENE_FALL)
							{
								numberOfBackCornerFalls += int(_1 == SCENE_FALL) + int(_7 == SCENE_FALL);
							}
							else if (_8 == SCENE_FALL)
							{
								numberOfBackCornerFalls += int(_1 == SCENE_FALL) + int(_3 == SCENE_FALL);
							}
							
							if (numberOfBackCornerFalls != 0)
								throw validationError;
						}
						else if (numberOfFallsNearby == 0)
						{
							var numberOfFallsAtTheCorner:int = 0;
							numberOfFallsAtTheCorner += int(_1 == SCENE_FALL);
							numberOfFallsAtTheCorner += int(_3 == SCENE_FALL);
							numberOfFallsAtTheCorner += int(_7 == SCENE_FALL);
							numberOfFallsAtTheCorner += int(_9 == SCENE_FALL);
							
							if (numberOfFallsAtTheCorner > 1)
								throw validationError;
						}
					}
					else if (_5 == SCENE_TL_DISK)
					{
						if (possTop.indexOf(_2) == -1 ||
							possLef.indexOf(_4) == -1 ||
							possBot.indexOf(_8) != -1 ||
							possRig.indexOf(_6) != -1)
							throw validationError;
					}
					else if (_5 == SCENE_TR_DISK)
					{
						if (possTop.indexOf(_2) == -1 ||
							possLef.indexOf(_4) != -1 ||
							possBot.indexOf(_8) != -1 ||
							possRig.indexOf(_6) == -1)
							throw validationError;
					}
					else if (_5 == SCENE_BL_DISK)
					{
						if (possTop.indexOf(_2) != -1 ||
							possLef.indexOf(_4) == -1 ||
							possBot.indexOf(_8) == -1 ||
							possRig.indexOf(_6) != -1)
							throw validationError;
					}
					else if (_5 == SCENE_BR_DISK)
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
		
		function getTileCodes():Array
		{
			var tileCodes:Array = new Array();
			
			for (var i:int = 0; i < map.tileset.length(); i++)
			{
				var name:String = map.tileset[i].@name;
				
				if (name == "fall")
					tileCodes[i + 1] = SCENE_FALL;
				else if (name == "ground")
					tileCodes[i + 1] = SCENE_GROUND;
				else if (name == "bot_left")
					tileCodes[i + 1] = SCENE_BL_DISK;
				else if (name == "bot_right")
					tileCodes[i + 1] = SCENE_BR_DISK;
				else if (name == "top_left")
					tileCodes[i + 1] = SCENE_TL_DISK;
				else if (name == "top_right")
					tileCodes[i + 1] = SCENE_TR_DISK;
			}
			
			return tileCodes;
		}
		
		function getSceneCell(x:int, y:int):int
		{
			return tileCodes[tiles[getCellId(x, y)].@gid];
		}
	}
	
}