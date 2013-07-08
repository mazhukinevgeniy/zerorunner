package chaotic.grinder 
{
	import chaotic.core.FeaturePack;
	
	public class GrinderFeature extends FeaturePack
	{
		internal static const NUMBER:int = 7;
		internal static const HEIGHT:int = 7;
		
		internal static const TIME_MIN:int = 5;
		
		public function GrinderFeature() 
		{
			this.list.push(new Grinders());
			this.list.push(new GrinderBehavior());
			this.list.push(new GrindersView());
		}
		
	}

}