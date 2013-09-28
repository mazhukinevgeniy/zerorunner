package utils.updates 
{
	
	final public class UpdateManager implements IUpdateDispatcher
	{
		private static var count:int = 0;
		
		
		private var methods:Object;
		private var currentListener:Object;
		
		private var helper:Object;
		
		public function UpdateManager(flowName:String) 
		{
			UpdateManager.count++;
			if (UpdateManager.count > 1)
				throw new Error();
			
			this.methods = new Object();
			
			this.workWithUpdateListener(this);
			this.addUpdateListener(UpdateManager.callExternalFlow);
			
			UpdateManager.newUpdateManager(this, flowName);
		}
		
		final public function workWithUpdateListener(listener:Object):void
		{
			this.currentListener = listener;
		}
		final public function addUpdateListener(method:String):void
		{
			if (this.methods[method] == null)
				this.methods[method] = new Vector.<Object>();
			
			if (this.currentListener.update::[method])
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