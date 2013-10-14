package data 
{
	
	internal class Defaults 
	{
		internal static const configDefaults:Object = 
		{
			width: 10,
			
			junks: 2,
			goal: Game.LIGHT_A_BEACON
		};
		
		internal static const progressDefaults:Object = 
		{
			level: 1,
			
			activeDroids: 0,
			
			beacon0: Game.NO_BEACON,
			beacon1: Game.NO_BEACON,
			beacon2: Game.NO_BEACON
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
							this.configDefaults, 
							this.progressDefaults, 
							this.preferencesDefaults, 
							this.statisticsDefaults];
		
		
		public function Defaults() 
		{
			throw new Error();
		}
		
	}

}