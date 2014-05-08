package binding
{
	import binding.IDependent;
	import controller.interfaces.IGameController;
	import controller.interfaces.IInputController;
	import controller.interfaces.INotifier;
	import controller.interfaces.ISoundController;
	import flash.utils.Dictionary;
	import model.interfaces.IScene;
	import model.interfaces.IStatus;
	import starling.utils.AssetManager;
	
	public class Binder implements IBinder
	{
		private var objects:Dictionary;
		
		private var subscribers:Vector.<IDependent>;
		
		public function Binder() 
		{
			this.subscribers = new Vector.<IDependent>();
			
			this.objects = new Dictionary();
		}
		
		public function triggerBinding():void
		{
			var length:int = this.subscribers.length;
			
			for (var i:int = 0; i < length; i++)
				this.subscribers[i].bindObjects(this);
		}
		
		public function addBindable(object:*, type:Class):void
		{
			if (this.objects[type])
				throw new Error("can't have more than two objects referenced this way");
			else if (object is type)
				this.objects[type] = object;
			else 
				throw new Error("passed object is not " + type);
		}
		
		public function requestBindingFor(object:IDependent):void
		{
			this.subscribers.push(object);
		}
		
		
		public function get scene():IScene { return this.objects[IScene]; }
		public function get gameStatus():IStatus { return this.objects[IStatus]; }
		public function get notifier():INotifier { return this.objects[INotifier]; }
		public function get assetManager():AssetManager { return this.objects[AssetManager]; }
		public function get gameController():IGameController { return this.objects[IGameController]; }
		public function get inputController():IInputController { return this.objects[IInputController]; }
		public function get soundController():ISoundController { return this.objects[ISoundController]; }
	}

}