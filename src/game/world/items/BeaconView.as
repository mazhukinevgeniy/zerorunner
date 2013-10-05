package game.world.items 
{
	import game.core.GameFoundations;
	import game.core.metric.Metric;
	import game.world.items.utils.ItemViewBase;
	import starling.display.DisplayObject;
	import starling.display.Image;
	
	internal class BeaconView extends ItemViewBase
	{
		private var view:Image;
		
		public function BeaconView(foundations:GameFoundations) 
		{
			super(foundations);
		}
		
		override protected function getView():DisplayObject
		{
			return this.view = new Image(this.atlas.getTexture("tmp_tower"));
		}
		
		internal function showConstruction(ratio:Number):void
		{
			this.view.scaleY = Math.min(1, Math.max(0.01, ratio));
			
			this.view.y = Metric.CELL_HEIGHT * (1 - 3 * ratio);
		}
	}

}