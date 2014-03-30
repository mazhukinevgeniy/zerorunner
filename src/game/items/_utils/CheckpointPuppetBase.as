package game.items._utils 
{
	import game.GameElements;
	import game.items.PuppetBase;
	import game.metric.ICoordinated;
	
	public class CheckpointPuppetBase extends PuppetBase
	{
		
		public function CheckpointPuppetBase(master:CheckpointMasterBase, 
		                                     elements:GameElements, cell:ICoordinated) 
		{
			super(master, elements, cell);
		}
		
		final override protected function get isPassive():Boolean { return true; }
		final override protected function get isDestructible():Boolean { return false; }
	}

}