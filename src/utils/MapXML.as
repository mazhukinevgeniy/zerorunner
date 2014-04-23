package utils 
{
	import flash.utils.ByteArray;
	
	public class MapXML 
	{
		[Embed(source = "../../res/map/map.tmx", mimeType = "application/octet-stream")]
		private static const map:Class;
		
		public function MapXML() 
		{
			
		}
		
		public static function getOne():XML
		{
			var code:ByteArray = new (MapXML.map)() as ByteArray;
			return new XML(code.readUTFBytes(code.length));
		}
	}

}