package game.items.junk 
{
	import game.items.base.cores.ContraptionCore;
	
	internal class Contraption extends ContraptionCore
	{
		
		public function Contraption() 
		{
			
		}
		
		
		override public function get progress():Number
		{
			return 0;
		}
		
		
		override public function applySoldering(value:int):void
		{
			this.applyDestruction();
			
			this.points.removePointOfInterest(Game.TOWER, this);
			
			this.flow.dispatchUpdate(Update.technicUnlocked, this);
		}
	}

}