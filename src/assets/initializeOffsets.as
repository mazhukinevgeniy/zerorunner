package assets 
{
	import starling.utils.AssetManager;
	
	internal function initializeOffsets(assetManager:AssetManager, atlasXML:XML):void
	{
		var game:XML = getOffsets(atlasXML.texture[0]);
		var scene:XML = getOffsets(atlasXML.texture[1]);
		
		assetManager.addXml("gameOffsets", game);
		assetManager.addXml("sceneOffsets", scene);
		
		
		
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
				img.width = pic.@transWidth.length() != 0 ? pic.@transWidth : pic.@width;
				
				img.appendChild(<height></height>);
				img.height = pic.@transHeight.length() != 0 ? pic.@transHeight : pic.@height;
			}
			
			return tmp;
		}
	}
	
}