package game.actors.types.checkpoint 
{
	import game.actors.types.ActorLogicBase;
	import game.actors.utils.ConfigKit;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	
	internal class CheckpointLogic extends ActorLogicBase
	{
		
		public function CheckpointLogic() 
		{
			super(new CheckpointView());
		}
		
		override protected function getSpawningCell():CellXY
		{
			var center:ICoordinated = this.world.getCenter();
			
			return new CellXY(center.x + 3, center.y - 2);
		}
		
		override protected function getConfig():ConfigKit
		{
			var config:ConfigKit = new ConfigKit();
			
			config.health = 10000000;
			config.movingSpeed = 10000000;
			config.actingSpeed = 10000000;
			
			return config;
		}
	}

}