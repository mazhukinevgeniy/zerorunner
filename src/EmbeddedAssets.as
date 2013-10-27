package  
{
	
	internal class EmbeddedAssets 
	{
		//TODO: embed everything here
		
		/* UI */
		
		[Embed(source = "../res/textures/shell0.png")]
		public static const shell0:Class;
		
		/* Game */
		
		[Embed(source="../res/textures/items0.png")]
		public static const items0:Class;
		
		[Embed(source="../res/textures/scene0.png")]
		public static const scene0:Class;
		
		/* XML */
		
		[Embed(source = "../res/textures/atlases.xml")]
		public static const atlases:Class;
		
		/* Sounds */
		
		[Embed(source = "../res/sounds/Veloma.mp3")]
        public static const Veloma:Class;
		
		[Embed(source = "../res/sounds/Paging.mp3")]
        public static const Paging:Class;
		
		/* Fonts */
		
		[Embed(source="../res/fonts/HiLoDeco.ttf", embedAsCFF="false", fontFamily="HiLo-Deco")]
		private static const HiLoDeco:Class;
		
		
		public function EmbeddedAssets() 
		{
			throw new Error();
		}
		
	}

}