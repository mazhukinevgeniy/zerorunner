package game.world.broods.checkpoint 
{
	import game.core.GameFoundations;
	import game.core.metric.Metric;
	import game.world.broods.ItemViewBase;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	
	internal class CheckpointView extends ItemViewBase
	{
		private var container:Sprite;
		
		public function CheckpointView(foundations:GameFoundations) 
		{
			super(foundations);	
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