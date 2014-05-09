package assets.xml 
{
	import flash.utils.ByteArray;
	
	public class FontXML
	{
		[Embed(source="../../../res/fonts/bananaBrick.fnt", mimeType="application/octet-stream")]
		private static const font:Class;
		
		public function FontXML() 
		{
			throw new Error();
		}
		
		public static function getOne():XML
		{
			var code:ByteArray = new (FontXML.font)() as ByteArray;
			return new XML(code.readUTFBytes(code.length));
		}
	}

}