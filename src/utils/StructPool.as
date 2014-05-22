package utils 
{
	/**
	 * Simple Pool
	 */
	public class StructPool 
	{
		private var structClass:Class;
		
		private var used:Array;
		private var free:Array;
		
		public function StructPool(structClass:Class) 
		{
			this.used = new Array();
			this.free = new Array();
			
			this.structClass = structClass;
		}
		
		public function getStruct():*
		{
			var struct:Object = this.free.pop();
			
			if (struct == null)
				struct = new structClass();
			
			this.used.push(struct);
			return struct;
		}
		
		public function freeEverythingUsed():void
		{
			var struct:Object = this.used.pop();
			
			while (struct)
			{
				this.free.push(struct);
				struct = this.used.pop();
			}
		}
	}
	//TODO: check if used everywhere where needed and possible

}