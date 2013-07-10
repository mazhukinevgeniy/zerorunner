package  
{
	import chaotic.core.Chaotic;
	import chaotic.core.IUpdateDispatcher;
	import gui.ChaoticGUI;
	
	internal class MasterChaotic extends Chaotic
	{
		
		
		public function MasterChaotic() 
		{
			
		}
		
		override protected function addFeatures():void
		{
			var flow:IUpdateDispatcher = this.updateFlow;
			
			new ChaoticGUI(flow);
			
		}
	}

}