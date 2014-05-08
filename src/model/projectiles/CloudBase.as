package model.projectiles 
{
	/*
	 * The base class for the cloud, associated with projectile generation
	 */
	public class CloudBase 
	{
		
		public function CloudBase() 
		{
			
		}
		
		
		internal function spawnProjectiles():void
		{
			throw new Error("must implement");
		}
	}

}