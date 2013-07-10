package game.actors.manipulator 
{
	import game.actors.manipulator.ActionBase;
	import game.actors.storage.Puppet;
	
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