package utils 
{
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	public function initializeAtlasMakerAtlases(assets:AssetManager, xml:XML):void
	{
		var numberOfAtlases:int = xml.texture.length();
		for (var i:int = 0; i < numberOfAtlases; i++)
		{
			var aXML:XML = adaptTextureAtlasMakerXML(xml.textures[i]);
			var name:String = removeExistingExtension(aXML.@imagePath);
			
			var atlas:TextureAtlas = new TextureAtlas(assets.getTexture(name), aXML);
			
			assets.addTextureAtlas(removeExistingZero(name), atlas);
		}
		
		function adaptTextureAtlasMakerXML(xml:XML):XML
		{
			var outString:String = "<TextureAtlas imagePath='";
			outString += xml.@file + "'>";
			
			var total:int = xml.image.length();
			
			var pics:XMLList = xml.image;
			
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
		
		function removeExistingExtension(str:String):String
		{
			var result:String = "";
			var length:int = String.length(str);
			
			for (var i:int = 0; i < length; i++)
			{
				if (str.charAt(i) == ".")
					return result;
				else result += str.charAt(i);
			}
			
			throw new Error();
		}
		
		function removeExistingZero(str:String):String
		{
			var result:String = "";
			var length:int = String.length(str);
			
			for (var i:int = 0; i < length; i++)
			{
				if (str.charAt(i) == "0")
					return result;
				else result += str.charAt(i);
			}
			
			throw new Error();
		}
	}
	
}