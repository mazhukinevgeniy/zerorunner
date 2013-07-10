package chaotic.grinder 
{
	import chaotic.core.IUpdateDispatcher;
	
	public class GrinderFeature
	{
		public static const grindingStreamMoved:String = "grindingStreamMoved";
		public static const addGrinders:String = "addGrinders";
		
		
		internal static const NUMBER:int = 7;
		internal static const HEIGHT:int = 7;
		
		internal static const TIME_MIN:int = 2;
		
		public function GrinderFeature(flow:IUpdateDispatcher) 
		{
			new Grinders(flow);
			new GrinderBehavior(flow);
			new GrindersView(flow);
		}
		
	}

}