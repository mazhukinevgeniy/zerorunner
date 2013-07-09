package chaotic.grinder 
{
	import chaotic.core.FeaturePack;
	import chaotic.updates.IUpdateDispatcher;
	
	public class GrinderFeature extends FeaturePack
	{
		internal static const NUMBER:int = 7;
		internal static const HEIGHT:int = 7;
		
		internal static const TIME_MIN:int = 5;
		
		public function GrinderFeature(flow:IUpdateDispatcher) 
		{
			this.list.push(new Grinders(flow));
			this.list.push(new GrinderBehavior(flow));
			this.list.push(new GrindersView(flow));
		}
		
	}

}