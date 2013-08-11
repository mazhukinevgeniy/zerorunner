package utils.updates 
{
	
	public class UpdateManager implements IUpdateDispatcher
	{
		public static const callExternalFlow:String = "callExternalFlow";
		
		
		private var methods:Object;
		private var currentListener:Object;
		
		private var helper:Object;
		
		public function UpdateManager(flowName:String) 
		{
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
		
		
		update function callExternalFlow(name:String, ... args):void
		{
			var flow:IUpdateDispatcher = UpdateManager.managers[name];
			flow.dispatchUpdate.apply(flow, args);
		}
		
		/*
		 * 
		 * Static zone.
		 * 
		 */
		
		private static var managers:Object;
		
		private static function newUpdateManager(item:UpdateManager, name:String):void
		{
			if (UpdateManager.managers == null)
				UpdateManager.managers = new Object();
			
			UpdateManager.managers[name] = item;
		}
	}

}