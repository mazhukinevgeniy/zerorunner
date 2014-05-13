package assets
{
	
	internal class EmbeddedAssets 
	{
		/* Sprites */
		
		[Embed(source="../../res/atlases/sprites0.png")]
		public static const sprites0:Class;
		
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