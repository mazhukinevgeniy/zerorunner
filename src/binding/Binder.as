package binding
{
	import binding.IDependent;
	import controller.interfaces.IInputController;
	import flash.utils.Dictionary;
	import model.interfaces.ICollectibles;
	import model.interfaces.IExploration;
	import model.interfaces.IInput;
	import model.interfaces.IItemSnapshotter;
	import model.interfaces.IProjectiles;
	import model.interfaces.ISave;
	import model.interfaces.IScene;
	import model.interfaces.IStatus;
	import starling.events.EventDispatcher;
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
		
		public function get save():ISave { return this.objects[ISave]; }
		public function get input():IInput { return this.objects[IInput]; }
		public function get scene():IScene { return this.objects[IScene]; }
		public function get gameStatus():IStatus { return this.objects[IStatus]; }
		public function get exploration():IExploration { return this.objects[IExploration]; }
		public function get projectiles():IProjectiles { return this.objects[IProjectiles]; }
		public function get assetManager():AssetManager { return this.objects[AssetManager]; }
		public function get collectibles():ICollectibles { return this.objects[ICollectibles]; }
		public function get eventDispatcher():EventDispatcher { return this.objects[EventDispatcher]; }
		public function get itemSnapshotter():IItemSnapshotter { return this.objects[IItemSnapshotter]; }
		public function get inputController():IInputController { return this.objects[IInputController]; }
	}

}