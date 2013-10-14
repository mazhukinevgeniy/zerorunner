package data 
{
	import flash.net.SharedObject;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	internal dynamic class SharedObjectManager extends Proxy
	{
		private const defaultSave:Object = 
		{
			game:
			{
				config:
				{
					width: 10,
					
					junks: 2,
					goal: Game.LIGHT_A_BEACON
				},
				
				progress:
				{
					level: 1,
					
					activeDroids: 0,
					
					beacon0: Game.NO_BEACON,
					beacon1: Game.NO_BEACON,
					beacon2: Game.NO_BEACON
				}
			},
			
			preferences:
			{
				mute: false
			},
			
			statistics:
			{
				distance: 0
			}
		};
		
		protected var so:SharedObject;
		
		public function SharedObjectManager() 
		{
			const PROJECT_NAME:String = "zeroRunner";
			
			this.so = SharedObject.getLocal(PROJECT_NAME);
		}
		
		override flash_proxy function getProperty(name:*):* 
		{
			return;
		}
		
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			return;
		}
	}

}