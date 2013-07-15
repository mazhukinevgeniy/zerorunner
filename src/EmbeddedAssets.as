package  
{
	
	internal class EmbeddedAssets 
	{
		// Textures
		
		[Embed(source="../res/assets/textures/atlases/sprites0.png")]
		public static const sprites0:Class;
		
		//Sounds
		
		[Embed(source="../res/assets/sounds/Veloma.mp3")]
        public static const Veloma:Class;
		
		[Embed(source="../res/assets/sounds/Paging.mp3")]
        public static const Paging:Class;
		
		
		public function EmbeddedAssets() 
		{
			
		}
		
	}

}