package game.world.items 
{
	import game.core.GameFoundations;
	import game.world.items.utils.ISolderable;
	import game.world.items.utils.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	
	public class JunkLogic extends ItemLogicBase implements ISolderable
	{
		private var flow:IUpdateDispatcher;
		
		public function JunkLogic(foundations:GameFoundations) 
		{
			super(new JunkView(foundations), foundations);
			
			this.flow = foundations.flow;
		}
		
		public function applySoldering(value:int):void
		{
			this.applyDestruction();
			
			this.flow.dispatchUpdate(Update.technicUnlocked, this);
		}
		
		public function get progress():Number
		{
			return 0;
		}
		
	}

}