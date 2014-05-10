package starling.extensions 
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class TextureAtlasLogger extends TextureAtlas
	{
		private var requested:Vector.<String>;
		
		public function TextureAtlasLogger(texture:Texture, atlasXml:XML=null) 
		{
			super(texture, atlasXml);
			
			this.requested = new Vector.<String>();
		}
		
		override public function getTexture(name:String):Texture 
		{
			if (this.requested.indexOf(name) == -1)
				this.requested.push(name);
			
			return super.getTexture(name);
		}
		
		public function tellWhatIsNeverRequested():void
		{
			var all:Vector.<String> = this.getNames();
			
			for each (var name:String in all)
				if (this.requested.indexOf(name) == -1)
					trace(name + " was never requested");
		}
	}

}