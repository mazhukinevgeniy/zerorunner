package chaotic.xml 
{
	import chaotic.utils.XMLByClass;
	
	
	public function getActorsXML():XML
	{
		return XMLByClass(EmbeddedXMLs.actors);
	}

}