package utils 
{
	import flash.xml.XMLNode;
	
	public function adaptTextureAtlasMakerXML(original:Class):XML
	{
		var inXML:XML = XMLByClass(original);
		
		var outString:String = "<TextureAtlas imagePath='";
		outString += inXML.texture.@file + "'>";
		
		var total:int = int(inXML.@numImages);
		
		var pics:XMLList = inXML..image;
		
		for (var i:int = 0; i < total; i++)
		{
			outString += "<SubTexture ";
			outString += "name='" + pics[i].@name + "' ";
			outString += "x='" + pics[i].@x + "' ";
			outString += "y='" + pics[i].@y + "' ";
			outString += "width='" + pics[i].@width + "' ";
			outString += "height='" + pics[i].@height + "' ";
			outString += "/>";
		}
		
		outString += "</TextureAtlas>";
		
		return new XML(outString);
	}
	
}