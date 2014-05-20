package model.items.concrete 
{
	import model.items.ItemBase;
	import model.items.structs.ItemParams;
	
	internal class PassiveItem extends ItemBase
	{
		private var _type:int;
		
		public function PassiveItem(type:int, params:ItemParams) 
		{
			super(params);
			
			this._type = type;
		}
		
		override public function get type():int 
		{
			return this._type;
		}
		
		override protected function get isDestructible():Boolean 
		{
			return false;
		}
	}

}