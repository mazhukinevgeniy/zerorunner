package assets.xml 
{
	import flash.utils.ByteArray;
	
	public class FontXML
	{
		[Embed(source="../../../res/fonts/bananaBrick.fnt", mimeType="application/octet-stream")]
		private static const BananaBrick:Class;
		
		[Embed(source="../../../res/fonts/FantasqueSansMono.fnt", mimeType="application/octet-stream")]
		private static const FantasqueSansMono:Class;
		
		
		public function FontXML() 
		{
			throw new Error();
		}
		
		internal static function getOne(font:String):XML
		{
			var code:ByteArray = new (FontXML[font])() as ByteArray;
			return new XML(code.readUTFBytes(code.length));
		}
		
		public static function getFantasqueSansMonoXML():XML
		{
			return FontXML.getOne("FantasqueSansMono");
		}
		
		public static function getBananaBrickXML():XML
		{
			return FontXML.getOne("BananaBrick");
		}
	}

}