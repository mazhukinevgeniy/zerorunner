package utils.informers 
{
	import flash.utils.Dictionary;
	
	public class InformerManager implements IGiveInformers, IStoreInformers
	{
		private var dictionary:Dictionary;
		
		public function InformerManager() 
		{
			this.dictionary = new Dictionary();
		}
		
		
		public function addInformer(key:Class, item:*):void
		{
			if (item is key)
				this.dictionary[key] = item;
			else
				throw new Error("IncompatibleFeature");
		}
		
		public function getInformer(itemClass:Class):*
		{
			var item:Object = this.dictionary[itemClass];
			
			if (item != null)
				return item;
			
			throw new Error();
		}
	}

}