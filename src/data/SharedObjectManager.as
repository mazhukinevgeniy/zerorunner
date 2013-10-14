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