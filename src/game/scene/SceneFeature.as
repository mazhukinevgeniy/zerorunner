package game.scene 
{
	import utils.updates.IUpdateDispatcher;
	
	public class SceneFeature
	{
		public static const FALL:int = 0;
		public static const ROAD:int = 1;
		
		
		internal static const NUMBER_OF_PATTERNS:int = 7;
		
		public function SceneFeature(flow:IUpdateDispatcher) 
		{
			new Scene(flow);
		}
		
	}

}