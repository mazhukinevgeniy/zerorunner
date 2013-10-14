package data 
{
	import flash.net.SharedObject;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	internal dynamic class SharedObjectManager extends Proxy
	{
		private const configDefaults:Object = 
		{
			width: 10,
			
			junks: 2,
			goal: Game.LIGHT_A_BEACON
		};
		
		private const progressDefaults:Object = 
		{
			level: 1,
			
			activeDroids: 0,
			
			beacon0: Game.NO_BEACON,
			beacon1: Game.NO_BEACON,
			beacon2: Game.NO_BEACON
		};
		
		private const preferencesDefaults:Object = 
		{
			mute: false
		};
		
		private const statisticsDefaults:Object = 
		{
			distance: 0
		};
		
		private const defaults:Vector.<Object> = new <Object>[
						this.configDefaults, 
						this.progressDefaults, 
						this.preferencesDefaults, 
						this.statisticsDefaults];
		
		
		
		protected var so:SharedObject;
		
		public function SharedObjectManager() 
		{
			checkNaming();
			
			const PROJECT_NAME:String = "zeroRunner";
			
			this.so = SharedObject.getLocal(PROJECT_NAME);
			
			
			
			/**
			 * This function is used to check if there're identical entry names.
			 * 
			 * It's called just once so performance issues are irrelevant.
			 */
			function checkNaming():void
			{
				var tmp:Object = new Object();
				
				for each (obj:Object in this.defaults)
				{
					for (property:String in obj)
					{
						if (tmp[property] == 1)
							throw new Error();
						else 
							tmp[property] = 1;
					}
				}
			}
		}
		
		
		
		override flash_proxy function getProperty(name:*):* 
		{
			return this.so.data[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			this.so.data[name] = value;
		}
		
	}

}