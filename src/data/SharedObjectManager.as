package data 
{
	import flash.net.SharedObject;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	internal dynamic class SharedObjectManager extends Proxy
	{
		
		protected var so:SharedObject;
		
		public function SharedObjectManager() 
		{
			checkNaming();
			
			const PROJECT_NAME:String = "zeroRunner";
			this.so = SharedObject.getLocal(PROJECT_NAME);
			this.initializeEntries();
			
			/**
			 * This function is used to check if there're identical entry names.
			 * 
			 * It's called just once so performance issues are irrelevant.
			 */
			function checkNaming():void
			{
				var tmp:Object = new Object();
				
				for each (var obj:Object in Defaults.defaults)
				{
					for (var property:String in obj)
					{
						if (tmp[property] == 1)
							throw new Error();
						else 
							tmp[property] = 1;
					}
				}
			}
		}
		
		/**
		 * This function is used to initialize missed entries
		 */
		private function initializeEntries():void
		{
			for each (var obj:Object in Defaults.defaults)
			{
				for (var property:String in obj)
				{
					if (!this.so.data.hasOwnProperty(property))
						this.so.data[property] = obj[property];
				}
			}
		}
		
		
		override flash_proxy function getProperty(name:*):* 
		{
			if (this.so.data.hasOwnProperty(name))
				return this.so.data[name];
			else throw new Error();
		}
		
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			this.so.data[name] = value;
		}
		
	}

}