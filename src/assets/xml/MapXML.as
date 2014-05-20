package assets.xml 
{
	import flash.utils.ByteArray;
	
	public class MapXML 
	{
		[Embed(source = "../../../res/map/map.tmx", mimeType = "application/octet-stream")]
		private static const MAP:Class;
		
		private static var map:XML;
		
		public function MapXML() 
		{
			
		}
		
		public static function getOne():XML
		{
			if (!MapXML.map)
			{
				var code:ByteArray = new (MapXML.MAP)() as ByteArray;
				MapXML.map = new XML(code.readUTFBytes(code.length));
			}
			return MapXML.map;
		}
		
		public static function getItemCodes():Array
		{
			var itemCodes:Array = new Array();
			
			var map:XML = MapXML.getOne();
			
			for (var i:int = 0; i < map.tileset.length(); i++)
			{
				var name:String = map.tileset[i].@name;
				
				if (name == "hero")
					itemCodes[i + 1] = Game.ITEM_CHARACTER;
				else if (name == "goal")
					itemCodes[i + 1] = Game.ITEM_THE_GOAL;
				else if (name == "radar")
					itemCodes[i + 1] = Game.ITEM_BEACON;
				else if (name == "shard")
					itemCodes[i + 1] = Game.ITEM_SHARD;
				else if (name == "spawn")
					itemCodes[i + 1] = Game.ITEM_THE_SPAWN;
			}
			
			return itemCodes;
		}
		
	}

}