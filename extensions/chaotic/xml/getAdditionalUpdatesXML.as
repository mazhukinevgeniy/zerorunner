package chaotic.xml 
{
	import chaotic.utils.XMLByClass;
	
	
	public function getAdditionalUpdatesXML():XML
	{
		return XMLByClass(EmbeddedXMLs.updates);
	}

}