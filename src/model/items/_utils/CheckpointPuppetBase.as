package model.items._utils 
{
	import model.items.PuppetBase;
	import model.metric.ICoordinated;
	
	public class CheckpointPuppetBase extends PuppetBase
	{
		
		public function CheckpointPuppetBase(master:CheckpointMasterBase, 
		                                     cell:ICoordinated) 
		{
			super(master, cell);
		}
		
		final override protected function get isPassive():Boolean { return true; }
		final override protected function get isDestructible():Boolean { return false; }
	}

}