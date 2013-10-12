package utils 
{
	import flash.net.SharedObject;
	
	public class SaveBase 
	{
		private const PROJECT_NAME:String = "zeroRunner";
		
		protected var localSave:SharedObject;
		
		public function SaveBase() 
		{
			this.localSave = SharedObject.getLocal(this.PROJECT_NAME);
			
			this.checkLocalSave();
		}
		
		protected function checkLocalSave():void
		{
			throw new Error();
		}
	}

}