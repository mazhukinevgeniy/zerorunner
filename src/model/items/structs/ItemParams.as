package model.items.structs 
{
	import binding.IBinder;
	import model.items.Items;
	
	public class ItemParams 
	{
		public var x:int, y:int;
		public var width:int, height:int;
		
		public var binder:IBinder;
		public var items:Items;
		
		public function ItemParams() 
		{
			
		}
		
	}

}