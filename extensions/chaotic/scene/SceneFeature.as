package chaotic.scene 
{
	import chaotic.core.IUpdateDispatcher;
	
	public class SceneFeature
	{
		public static const addedScenePiece:String = "addedScenePiece";
		
		public static const FALL:int = 0;
		public static const ROAD:int = 1;
		
		public static const DRAWING_FALL:int = 0;
		public static const DRAWING_ROAD:int = 1;
		
		
		internal static const NUMBER_OF_PATTERNS:int = 5;
		
		public function SceneFeature(flow:IUpdateDispatcher) 
		{
			new Scene(flow);
			new LandscapeCanvas(flow);
		}
		
	}

}