package data 
{
	
	public class Defaults 
	{
		
		public static const progressDefaults:Object = 
		{
			width: 10,
			
			junks: 2,
			goal: Game.GOAL_LIGHT_A_BEACON,
			
			level: 1,
			
			activeDroids: 0,
			
			beacon1: Game.CONTRAIL_NO_BEACON,
			beacon2: Game.CONTRAIL_NO_BEACON,
			beacon3: Game.CONTRAIL_NO_BEACON,
			
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