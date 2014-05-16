package assets.xml 
{
	import flash.utils.ByteArray;
	
	public class SaveXML
	{
		[Embed(source="../../../res/config/save.xml", mimeType = "application/octet-stream")]
		private static const save:Class;
		
		public function SaveXML() 
		{
			throw new Error();
		}
		
		public static function getOne():XML
		{
			var code:ByteArray = new (SaveXML.save)() as ByteArray;
			return new XML(code.readUTFBytes(code.length));
		}
	}

}