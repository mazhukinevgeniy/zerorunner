package game.actors.manipulator.onDamaged 
{
	import game.actors.ActorsFeature;
	import game.actors.manipulator.ActionBase;
	import game.actors.storage.Puppet;
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
			this.updateFlow.dispatchUpdate(ActorsFeature.protagonistDamaged, args[0]);
		}
	}

}