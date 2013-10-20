package  
{
	
	internal class EmbeddedAssets 
	{
		//Textures
		
		[Embed(source="../res/assets/textures/atlases/sprites0.png")]
		public static const sprites0:Class;
		
		[Embed(source="../res/assets/textures/hexagon.png")]
		public static const hexagon:Class;
		
		[Embed(source = "../res/assets/textures/testcloud.png")]
		public static const testcloud:Class;
		
		//Sounds
		
		[Embed(source="../res/assets/sounds/Veloma.mp3")]
        public static const Veloma:Class;
		
		[Embed(source="../res/assets/sounds/Paging.mp3")]
        public static const Paging:Class;
		
		//Fonts
		
		[Embed(source="../res/assets/fonts/HiLoDeco.ttf", embedAsCFF="false", fontFamily="HiLo-Deco")]
		private static const HiLoDeco:Class;
		
		
		public function EmbeddedAssets() 
		{
			throw new Error();
		}
		
	}

}