package chaotic.scene 
{
	import chaotic.core.FeaturePack;
	
	public class SceneFeature extends FeaturePack
	{
		public static const FALL:int = 0;
		public static const ROAD:int = 1;
		
		public static const DRAWING_FALL:int = 0;
		public static const DRAWING_ROAD:int = 1;
		
		
		internal static const NUMBER_OF_PATTERNS:int = 5;
		
		public function SceneFeature() 
		{
			this.list.push(new Scene());
			this.list.push(new LandscapeCanvas());
		}
		
	}

}