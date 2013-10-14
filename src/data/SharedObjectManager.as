package data 
{
	import flash.net.SharedObject;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	/**
	 * This class wraps SharedObject. Its objects are to never be accessed from the outer packages.
	 */
	internal dynamic class SharedObjectManager extends Proxy
	{
		
		protected var so:SharedObject;
		
		public function SharedObjectManager() 
		{
			checkNaming();
			
			const PROJECT_NAME:String = "zeroRunner";
			this.so = SharedObject.getLocal(PROJECT_NAME);
			
			initializeEntries();
			
			
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
			
			/**
			 * This function is used to initialize missed entries
			 */
			function initializeEntries():void
			{
				for each (obj:Object in Defaults.defaults)
				{
					for (property:String in obj)
					{
						if (!this.so.data.hasOwnProperty(property)) 
						//TODO: check if works
							this.so.data[property] = obj[property];
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