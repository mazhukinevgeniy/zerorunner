package data 
{
	import flash.geom.Point;
	
	public class Defaults 
	{
		
		public static const progressDefaults:Object = 
		{
			width: 10,
			
			junks: 2,
			goal: Game.LIGHT_A_BEACON,
			
			level: 1,
			
			activeDroids: 0,
			
			beacon1: Game.NO_BEACON,
			beacon2: Game.NO_BEACON,
			beacon3: Game.NO_BEACON,
			
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
		
		public static const achievementsDefaults:Object = 
		{
			achievements: new Vector.<Vector.<Object>>,
			achievementsEdge: new Vector.<Object>
		};
		
		internal static const defaults:Vector.<Object> = new <Object>[
							Defaults.progressDefaults, 
							Defaults.preferencesDefaults, 
							Defaults.statisticsDefaults,
							Defaults.achievementsDefaults];
		
		
		public function Defaults() 
		{
			throw new Error();
		}
		
	}

}