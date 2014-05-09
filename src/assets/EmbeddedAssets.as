package assets
{
	
	internal class EmbeddedAssets 
	{
		/* Sprites */
		
		[Embed(source="../../res/atlases/sprites0.png")]
		public static const sprites0:Class;
		
		[Embed(source="../../res/fonts/bananaBrick.png")]
		public static const bananaBrick:Class;
		
		[Embed(source = "../../res/fonts/hiloDeco.png")]
		public static const hiloDeco:Class;
		
		[Embed(source = "../../res/atlases/scene0.png")]
		public static const scene0:Class;
		
		/* Sounds */
		
		[Embed(source = "../../res/sounds/Veloma.mp3")]
        public static const Veloma:Class;
		
		[Embed(source = "../../res/sounds/Paging.mp3")]
        public static const Paging:Class;
		
		/* Fonts */
		
		//[Embed(source="../../res/fonts/HiLoDeco.ttf", embedAsCFF="false", fontFamily="HiLo-Deco")]
		//private static const HiLoDeco:Class;
		
		public function EmbeddedAssets() 
		{
			throw new Error();
		}
		
	}

}