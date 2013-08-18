package game.world.broods.utils 
{
	
	public class ConfigKit 
	{
		public static const CLOUD:ConfigKit = new ConfigKit(1, 0, 10000000);
		
		public var health:int;
		public var movingSpeed:int;
		public var actingSpeed:int;
		
		public function ConfigKit(health:int, moveSpeed:int, actSpeed:int) 
		{
			this.health = health;
			
			this.movingSpeed = moveSpeed;
			this.actingSpeed = actSpeed;
		}
		
	}

}