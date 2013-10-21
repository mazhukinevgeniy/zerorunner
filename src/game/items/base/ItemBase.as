package game.items.base 
{
	import game.items.base.cores.ActivityCore;
	import game.items.base.cores.CollisionCore;
	import game.items.base.cores.ContraptionCore;
	import game.items.base.cores.ElectricityCore;
	import game.items.base.cores.ExistenceCore;
	import game.items.items_internal;
	import starling.display.DisplayObject;
	
	public class ItemBase
	{
		protected var _contraption:ContraptionCore;
		protected var _electricity:ElectricityCore;
		protected var _collider:CollisionCore;
		protected var _activity:ActivityCore;
		
		private var _existence:ExistenceCore;
		private var _view:ItemViewBase;
		
		/**
		 * Don't call super until the ... //TODO: until what?
		 */
		public function ItemBase(view:ItemViewBase, existence:ExistenceCore) 
		{
			this._view = view;
			
			if (existence == null)
				this._existence = new ExistenceCore(null);
			else
				this._existence = existence;
		}
		
		public function act():void
		{
			
		}
		
		
		
		
		final items_internal function get contraption():ContraptionCore { return this._contraption; }
		final items_internal function get electricity():ElectricityCore { return this._electricity; }
		final items_internal function get existence():ExistenceCore { return this._existence; }
		final items_internal function get collider():CollisionCore { return this._collider; }
		final items_internal function get actor():ActivityCore { return this._activity; }
		
		final items_internal function get view():ItemViewBase { return this._view; }
		
		/**
		 * for the external use
		 */
		
		final public function getView():DisplayObject
		{
			return this._view;
		}
	}

}