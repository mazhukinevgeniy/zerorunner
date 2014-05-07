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
	}

}