package utils 
{
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	public function initializeAtlasMakerAtlases(assets:AssetManager, xml:XML):void
	{
		var numberOfAtlases:int = xml.texture.length();
		for (var i:int = 0; i < numberOfAtlases; i++)
		{
			var aXML:XML = adaptTextureAtlasMakerXML(xml.texture[i]);
			var name:String = removeExistingExtension(aXML.@imagePath);
			
			var atlas:TextureAtlas = new TextureAtlas(assets.getTexture(name), aXML);
			
			assets.addTextureAtlas(removeExistingZero(name), atlas);
		}
		
		assets.addXml("offsets", getOffsets(xml.texture[0]));
		
		function getOffsets(texture:XML):XML
		{
			var tmp:XML = <offsets></offsets>;
			
			var pics:XMLList = texture.image;
			var total:int = pics.length();
			
			for (var i:int = 0; i < total; i++)
			{
				var pic:XML = pics[i];
				
				tmp.appendChild(
					new XML("<" + pic.@name + ">" + 
					        "</" + pic.@name + ">"));
				
				var img:XML = tmp.children()[i];
				
				img.appendChild(<xOffset></xOffset>);
				img.xOffset = pic.@xOffset.length() ? pic.@xOffset : 0;
				
				img.appendChild(<yOffset></yOffset>);
				img.yOffset = pic.@yOffset.length() ? pic.@yOffset : 0;
				
				img.appendChild(<width></width>);
				img.width = pic.@transWidth.length() ? pic.@transWidth : pic.@width;
				
				img.appendChild(<height></height>);
				img.height = pic.@transHeight.length() ? pic.@transHeight : pic.@height;
			}
			
			return tmp;
		}
		
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
			
			trace(tmp.toString());
			
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