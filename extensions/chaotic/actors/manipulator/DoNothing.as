package chaotic.actors.manipulator 
{
	import chaotic.actors.manipulator.ActionBase;
	import chaotic.actors.storage.Puppet;
	
	public class DoNothing extends ActionBase
	{
		
		public function DoNothing() 
		{
			
		}
		
		override public function actOn(item:Puppet, ... args):void
		{
			
		}
		
		override public function prepareDataIn(item:Puppet):void
		{
			
		}
	}

}