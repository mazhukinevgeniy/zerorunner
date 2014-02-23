package data 
{
	import flash.geom.Point;
	
	public class Defaults 
	{
		
		public static const progressDefaults:Object = 
		{
			activeDroids: 0,
			
			cloudiness: 0,
			
			distance: 0
		};
		
		internal static const preferencesDefaults:Object = 
		{
			mute: false//settings are unresettable
		};
		
		public static const achievementsDefaults:Object = 
		{
			achievements: new Vector.<Vector.<Object>>,
			achievementsEdge: new Vector.<Object>
		};
		
		internal static const defaults:Vector.<Object> = new <Object>[
							Defaults.progressDefaults, 
							Defaults.preferencesDefaults,
							Defaults.achievementsDefaults];
		
		
		public function Defaults() 
		{
			throw new Error();
		}
		
	}

}