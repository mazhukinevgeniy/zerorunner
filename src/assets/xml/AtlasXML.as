package assets.xml 
{
	import flash.utils.ByteArray;
	
	public class AtlasXML
	{
		[Embed(source="../../../res/atlases/atlases.xml", mimeType = "application/octet-stream")]
		private static const atlases:Class;
		
		public function AtlasXML() 
		{
			throw new Error();
		}
		
		public static function getOne():XML
		{
			var code:ByteArray = new (AtlasXML.atlases)() as ByteArray;
			return new XML(code.readUTFBytes(code.length));
		}
	}

}