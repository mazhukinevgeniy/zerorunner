package utils.updates 
{
	
	final public class UpdateManager implements IUpdateDispatcher
	{
		private static var count:int = 0;
		
		
		private var methods:Object;
		private var currentListener:Object;
		
		private var helper:Object;
		
		public function UpdateManager() 
		{
			UpdateManager.count++;
			if (UpdateManager.count > 1)
				throw new Error();
			
			this.methods = new Object();
		}
		
		final public function workWithUpdateListener(listener:Object):void
		{
			this.currentListener = listener;
		}
		final public function addUpdateListener(method:String):void
		{
			if (Update[method] == null)
				throw new Error("Must name methods in the Update.as");
			
			if (this.methods[method] == null)
				this.methods[method] = new Vector.<Object>();
			
			if (this.currentListener.update::[method] && this.methods[method].indexOf(this.currentListener) == -1)
				this.methods[method].push(this.currentListener);
			else throw new Error();
		}
		
		final public function dispatchUpdate(updateName:String, ... args):void
		{
			var vector:Vector.<Object> = this.methods[updateName];
			var length:int = vector.length;
			
			
			for (var i:int = 0; i < length; i++)
			{
				this.helper = vector[i];
				this.helper.update::[updateName].apply(this.helper, args);
			}
		}
	}

}