package  
{
	
	internal class EmbeddedAssets 
	{
		//TODO: embed everything here
		
		/* UI */
		
		[Embed(source="../res/textures/hexagon.png")]
		public static const hexagon:Class;
		
		/* Clouds */
		
		[Embed(source = "../res/textures/testcloud.png")]
		public static const testcloud:Class;
		
		/* Items */
		
		[Embed(source = "../res/textures/unimplemented.png")]
		public static const unimplemented:Class;
		
		[Embed(source = "../res/textures/hero/hero_stand.png")]
		public static const hero_stand:Class;
		
		/* Ground */
		
		[Embed(source = "../res/textures/ground/ground.png")]
		public static const ground:Class;
		
		[Embed(source = "../res/textures/ground/ground_E.png")]
		public static const ground_E:Class;
		
		[Embed(source = "../res/textures/ground/ground_N.png")]
		public static const ground_N:Class;
		
		[Embed(source = "../res/textures/ground/ground_NE.png")]
		public static const ground_NE:Class;
		
		[Embed(source = "../res/textures/ground/ground_NW.png")]
		public static const ground_NW:Class;
		
		[Embed(source = "../res/textures/ground/ground_S.png")]
		public static const ground_S:Class;
		
		[Embed(source = "../res/textures/ground/ground_SE.png")]
		public static const ground_SE:Class;
		
		[Embed(source = "../res/textures/ground/ground_SW.png")]
		public static const ground_SW:Class;
		
		[Embed(source = "../res/textures/ground/ground_W.png")]
		public static const ground_W:Class;
		
		[Embed(source = "../res/textures/ground/stones1.png")]
		public static const stones1:Class;
		
		[Embed(source = "../res/textures/ground/stones2.png")]
		public static const stones2:Class;
		
		[Embed(source = "../res/textures/ground/stones3.png")]
		public static const stones3:Class;
		
		/* Lava */
		
		[Embed(source = "../res/textures/lava/lava.png")]
		public static const lava:Class;
		
		[Embed(source = "../res/textures/lava/lava_E.png")]
		public static const lava_E:Class;
		
		[Embed(source = "../res/textures/lava/lava_N.png")]
		public static const lava_N:Class;
		
		[Embed(source = "../res/textures/lava/lava_NE.png")]
		public static const lava_NE:Class;
		
		[Embed(source = "../res/textures/lava/lava_NW.png")]
		public static const lava_NW:Class;
		
		[Embed(source = "../res/textures/lava/lava_S.png")]
		public static const lava_S:Class;
		
		[Embed(source = "../res/textures/lava/lava_SE.png")]
		public static const lava_SE:Class;
		
		[Embed(source = "../res/textures/lava/lava_SW.png")]
		public static const lava_SW:Class;
		
		[Embed(source = "../res/textures/lava/lava_W.png")]
		public static const lava_W:Class;
		
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