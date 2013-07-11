package game.scene 
{
	import chaotic.core.IUpdateDispatcher;
	
	public class SceneFeature
	{
		public static const FALL:int = 0;
		public static const ROAD:int = 1;
		
		
		internal static const NUMBER_OF_PATTERNS:int = 5;
		
		public function SceneFeature(flow:IUpdateDispatcher) 
		{
			var cache:LandscapeCache = new LandscapeCache(new Scene(flow));
			new LandscapeCanvas(flow, cache);
		}
		
	}

}