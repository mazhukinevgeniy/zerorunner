package chaotic.actors.manipulator.onDamaged 
{
	import chaotic.actors.manipulator.ActionBase;
	import chaotic.actors.storage.Puppet;
	import chaotic.core.IUpdateDispatcher;
	
	public class ProtagonistDamaged extends ActionBase
	{
		private var updateFlow:IUpdateDispatcher;
		
		public function ProtagonistDamaged(flow:IUpdateDispatcher) 
		{
			this.updateFlow = flow;
		}
		
		override public function actOn(item:Puppet, ... args):void
		{
			this.updateFlow.dispatchUpdate("protagonistDamaged", args[0]);
		}
	}

}