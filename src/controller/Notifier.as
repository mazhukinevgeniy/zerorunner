package controller 
{
	import controller.interfaces.INotifier;
	import controller.observers.*;
	import flash.utils.Dictionary;
	import model.collectibles.Collectible;
	import model.metric.DCellXY;
	import model.projectiles.Projectile;
	
	internal class Notifier implements INotifier
	{
		private var observers:Dictionary;
		
		private var supportedInterfaces:Vector.<Class>;
		
		public function Notifier() 
		{
			this.observers = new Dictionary();
			
			this.supportedInterfaces = new <Class>[
				ISoundObserver,
				ICollectibleObserver,
				IScreenObserver, IGameObserver,
				IActivationObserver, IDeactivationObserver,
				INewGameHandler, IQuitGameHandler,
				IGameFrameHandler, IGameStopHandler,
				IGameMenuObserver, IGameMapObserver,
				IMapFrameHandler, IInputObserver,
				IShardObserver];
			
			for each (var observerClass:Class in this.supportedInterfaces)
			{
				this.observers[observerClass] = new Array();
			}
		}
		
		public function addObserver(observer:Object):void
		{
			for each (var observerClass:Class in this.supportedInterfaces)
			{
				if (observer is observerClass &&
					this.observers[observerClass].indexOf(observer) == -1)
				{
					this.observers[observerClass].push(observer);
				}
			}
		}
		
		
		internal function call(observerType:Class, method:String, ... args):void
		{
			var list:Array = this.observers[observerType];
			
			var length:int = list.length;
			for (var i:int = 0; i < length; i++)
			{
				var called:Object = list[i];
				
				called[method].apply(called, args);
			}
		}
	}

}