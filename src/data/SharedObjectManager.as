package data 
{
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	internal dynamic class SharedObjectManager extends Proxy
	{
		
		public function SharedObjectManager() 
		{
			
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