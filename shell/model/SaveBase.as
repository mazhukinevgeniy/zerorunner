package model 
{
	import flash.net.SharedObject;
	
	public class SaveBase 
	{
		protected var localSave:SharedObject;
		
		public function SaveBase() 
		{
			this.localSave = SharedObject.getLocal("localSaveFile");
		}
		
	}

}