package assets.xml 
{
	import flash.utils.ByteArray;
	
	public class FontXML
	{
		[Embed(source="../../../res/fonts/bananaBrick.fnt", mimeType="application/octet-stream")]
		private static const bananaBrick:Class;
		
		[Embed(source = "../../../res/fonts/hiloDeco.fnt", mimeType = "application/octet-stream")]
		private static const hiloDeco:Class;
		
		
		public function FontXML() 
		{
			throw new Error();
		}
		
		internal static function getOne(font:String):XML
		{
			var code:ByteArray = new (FontXML[font])() as ByteArray;
			return new XML(code.readUTFBytes(code.length));
		}
		
		public static function getHiloDecoXML():XML
		{
			return FontXML.getOne("hiloDeco");
		}
		
		public static function getBananaBrickXML():XML
		{
			return FontXML.getOne("bananaBrick");
		}
	}

}