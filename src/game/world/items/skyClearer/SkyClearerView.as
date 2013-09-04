package game.world.items.skyClearer 
{
	import game.core.GameFoundations;
	import game.core.metric.Metric;
	import game.world.items.ItemViewBase;
	import starling.display.DisplayObject;
	import starling.display.Image;
	
	internal class SkyClearerView extends ItemViewBase
	{
		private var view:Image;
		
		public function SkyClearerView(foundations:GameFoundations) 
		{
			super(foundations);
		}
		
		override protected function getView():DisplayObject
		{
			return this.view = new Image(this.atlas.getTexture("unimplemented"));
		}
		
		internal function showConstruction(value:int):void
		{
			var nheight:Number = Math.max(0.1, value / SkyClearerLogic.MAXIMUM_CONSTRUCTION);
			
			this.view.scaleY = nheight + (nheight > 1 ? 0.2 : 0);
			this.view.y = Metric.CELL_HEIGHT * (1 - this.view.scaleY);
		}
	}

}