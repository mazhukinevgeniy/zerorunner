package game.items.utils 
{
	
	public class ConfigKit 
	{
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