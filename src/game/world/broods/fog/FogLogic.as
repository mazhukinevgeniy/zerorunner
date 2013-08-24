package game.world.broods.fog 
{
	import game.utils.GameFoundations;
	import game.utils.metric.DCellXY;
	import game.world.broods.IPushable;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.IWindBound;
	
	public class FogLogic extends ItemLogicBase implements IPushable, IWindBound
	{
		private const MOVE_SPEED:int = 0;
		
		public function FogLogic(foundations:GameFoundations) 
		{
			super(new FogView(foundations), foundations);
		}
		
		
		
		
		protected function onPushed():void
		{
			this.applyDestruction();
		}
		
		
		
		public function applyWind(change:DCellXY):void
		{
			if (this.world.findObjectByCell(this.x + change.x, this.y + change.y))
				this.applyDestruction();
			else
				this.move(change, this.MOVE_SPEED);
		}
	}

}