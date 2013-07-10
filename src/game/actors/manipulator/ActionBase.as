package game.actors.manipulator 
{
	import game.actors.storage.Puppet;
	import chaotic.errors.AbstractClassError;
	
	public class ActionBase
	{
		protected var performer:IActionPerformer;
		
		public function ActionBase() 
		{
			
		}
		
		public function actOn(item:Puppet, ... args):void
		{
			throw new AbstractClassError();
		}
		
		public function prepareDataIn(item:Puppet):void
		{
			throw new AbstractClassError();
		}
	}

}