package listeners 
{
	
	internal class ProcessorBase 
	{
		
		public function ProcessorBase() 
		{
			
		}
		
		internal function processInput(keyUp:Boolean, keyCode:uint):void
		{
			throw new Error("must implement");
		}
	}

}