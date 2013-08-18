package game.broods.checkpoint 
{
	import game.broods.ItemViewBase;
	import game.core.time.Time;
	import game.utils.metric.Metric;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	
	internal class CheckpointView extends ItemViewBase
	{
		private var container:Sprite;
		
		public function CheckpointView() 
		{
			
		}
		
		override protected function getView():DisplayObject
		{
			this.container = new Sprite();
			this.container.addChild(new Image(this.atlas.getTexture("unimplemented")));
			
			var black:Image = new Image(this.atlas.getTexture("fall"));
			black.scaleX = black.scaleY = 0.6;
			black.x = black.y = (Metric.CELL_WIDTH - black.width) / 2;
			
			this.container.addChild(black);
			
			return this.container;
		}
	}

}