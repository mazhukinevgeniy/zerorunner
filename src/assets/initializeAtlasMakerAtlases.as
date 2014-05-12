package assets 
{
	import starling.extensions.TextureAtlasLogger;
	import starling.utils.AssetManager;
	
	internal function initializeAtlasMakerAtlases(assetManager:AssetManager, xml:XML):void
	{
		var numberOfAtlases:int = xml.texture.length();
		for (var i:int = 0; i < numberOfAtlases; i++)
		{
			var aXML:XML = adaptTextureAtlasMakerXML(xml.texture[i]);
			var name:String = removeExistingExtension(aXML.@imagePath);
			
			var atlas:TextureAtlasLogger = new TextureAtlasLogger(assetManager.getTexture(name), aXML);
			
			assetManager.addTextureAtlas(removeExistingZero(name), atlas);
		}
		
		initializeOffsets(assetManager, xml);
		
		function adaptTextureAtlasMakerXML(xml:XML):XML
		{
			var tmp:XML = new XML("<TextureAtlas></TextureAtlas>");
			tmp.@imagePath = xml.@file;
			
			var pics:XMLList = xml.image;
			var total:int = pics.length();
			
			for (var i:int = 0; i < total; i++)
			{
				tmp.appendChild(<SubTexture/>);
				
				var st:XML = tmp.children()[i];
				var pic:XML = pics[i];
				
				st.@name = pic.@name;
				st.@x = pic.@x;
				st.@y = pic.@y;
				
				st.@width = pic.@width;
				st.@height = pic.@height;
			}
			
			return tmp;
		}
		
		function removeExistingExtension(str:String):String
		{
			var result:String = "";
			var length:int = str.length;
			
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
			var length:int = str.length;
			
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