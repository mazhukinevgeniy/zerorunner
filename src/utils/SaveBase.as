package utils 
{
	import flash.net.SharedObject;
	
	public class SaveBase 
	{
		protected var localSave:SharedObject;
		
		public function SaveBase() 
		{
			this.localSave = SharedObject.getLocal(Main.PROJECT_NAME);
			
			this.checkLocalSave();
		}
		
		protected function checkLocalSave():void
		{
			throw new Error();
		}
	}

}