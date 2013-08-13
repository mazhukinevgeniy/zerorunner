package game.actors.types.clouds.fog 
{
	import game.actors.types.clouds.CloudLogicBase;
	import game.metric.DCellXY;
	import game.metric.Metric;
	
	internal class FogLogic extends CloudLogicBase
	{
		
		public function FogLogic() 
		{
			super(new FogView());
		}
		
		override protected function onCanMove():void
		{
			this.move(Metric.getRandomDCell());
			
			//TODO: finalize before
		}
		
		
		
		override protected function onPushed():void
		{
			this.applyDestruction();
		}
		
		override protected function onBlocked(change:DCellXY):void
		{
			this.applyPush();
		}
		
	}

}