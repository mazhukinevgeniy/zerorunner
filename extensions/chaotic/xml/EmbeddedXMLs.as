package chaotic.xml 
{
	import chaotic.errors.StaticClassError;
	
	internal class EmbeddedXMLs 
	{
		[Embed(source = "actors.xml", mimeType="application/octet-stream")]
		internal static const actors:Class;
		
		[Embed(source="updates.xml", mimeType="application/octet-stream")]
		internal static const updates:Class;
		
		
		public function EmbeddedXMLs() 
		{
			throw new StaticClassError();
		}
		
	}

}