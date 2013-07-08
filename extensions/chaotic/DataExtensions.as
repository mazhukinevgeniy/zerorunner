package chaotic 
{
	import chaotic.choosenArea.ChoosenArea;
	import chaotic.core.FeaturePack;
	import chaotic.input.InputManager;
	import chaotic.statistics.Statistics;
	
	public class DataExtensions extends FeaturePack
	{
		
		public function DataExtensions() 
		{
			this.list.push(new InputManager());
			this.list.push(new Statistics());
			this.list.push(new ChoosenArea());
		}
		
	}

}