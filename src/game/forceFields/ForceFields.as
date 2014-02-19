package game.forceFields 
{
	import utils.updates.IUpdateDispatcher;
	
	public class ForceFields implements IForceField
	{
		
		public function ForceFields(flow:IUpdateDispatcher) 
		{
			
		}
		
		
		
		
		
		public function isCellCovered(x:int, y:int):Boolean
		{
			return false;
			//TODO: +-7
		}
	}

}