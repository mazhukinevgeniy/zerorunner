package chaotic.actors.manipulator.onDamaged 
{
	import chaotic.actors.manipulator.ActionBase;
	import chaotic.actors.storage.Puppet;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.updates.Update;
	
	public class ProtagonistDamaged extends ActionBase
	{
		private var updateFlow:IUpdateDispatcher;
		
		public function ProtagonistDamaged(flow:IUpdateDispatcher) 
		{
			this.updateFlow = flow;
		}
		
		override public function actOn(item:Puppet, ... args):void
		{
			this.updateFlow.dispatchUpdate(new Update("protagonistDamaged", args[0]));
		}
	}

}