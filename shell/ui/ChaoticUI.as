package ui 
{
	import chaotic.core.Chaotic;
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	
	public class ChaoticGUI extends Chaotic
	{
		private var masterFlow:IUpdateDispatcher;
		
		public function ChaoticGUI(displayRoot:DisplayObjectContainer, masterFlow:IUpdateDispatcher) 
		{
			this.masterFlow = masterFlow;
			
			super();
		}
		
		override protected function addFeatures():void
		{
			var flow:IUpdateDispatcher = this.updateFlow;
			
			
		}
	}

}