package data 
{
	
	public class Defaults 
	{
		
		public static const progressDefaults:Object = 
		{
			activeDroids: 0,
			
			cloudiness: 0
		};
		
		internal static const preferencesDefaults:Object = 
		{
			mute: false
		};
		
		internal static const statisticsDefaults:Object = 
		{
			distance: 0
		};
		
		internal static const defaults:Vector.<Object> = new <Object>[
							Defaults.progressDefaults, 
							Defaults.preferencesDefaults, 
							Defaults.statisticsDefaults];
		
		
		public function Defaults() 
		{
			throw new Error();
		}
		
	}

}