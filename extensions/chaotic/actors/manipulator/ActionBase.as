package chaotic.actors.manipulator 
{
	import chaotic.actors.storage.Puppet;
	import chaotic.errors.AbstractClassError;
	
	public class ActionBase
	{
		protected var performer:IActionPerformer;
		
		public function ActionBase() 
		{
			
		}
		
		public function actOn(item:Puppet):void
		{
			throw new AbstractClassError();
		}
		
		public function prepareDataIn(item:Puppet):void
		{
			throw new AbstractClassError();
		}
	}

}