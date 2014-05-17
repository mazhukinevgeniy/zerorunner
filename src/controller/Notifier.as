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
		
		internal function setCollectibleFound(collectible:Collectible):void
		{
			this.call(ICollectibleObserver, "setCollectibleFound", collectible);
		}
		internal function screenActivated(name:String):void
		{
			this.call(IScreenObserver, "screenActivated", name);
		}
		internal function processActivation():void
		{
			this.call(IActivationObserver, "processActivation");
		}
		internal function processDeactivation():void
		{
			this.call(IDeactivationObserver, "processDeactivation");
		}
		internal function setSoundMute(type:int, value:Boolean):void
		{
			this.call(ISoundObserver, "setSoundMute", type, value);
		}
		internal function setSoundVolume(type:int, value:Number):void
		{
			this.call(ISoundObserver, "setSoundVolume", type, value);
		}
		internal function newGame():void
		{
			this.call(INewGameHandler, "newGame");
		}
		internal function quitGame():void
		{
			this.call(IQuitGameHandler, "quitGame");
		}
		internal function gameFrame(frame:int):void
		{
			this.call(IGameFrameHandler, "gameFrame", frame);
		}
		internal function mapFrame():void
		{
			this.call(IMapFrameHandler, "mapFrame");
		}
		internal function gameStopped(reason:int):void
		{
			this.call(IGameStopHandler, "gameStopped", reason);
		}
		internal function showGameMenu():void
		{
			this.call(IGameMenuObserver, "showGameMenu");
		}
		internal function showGame():void
		{
			this.call(IGameObserver, "showGame");
		}
		internal function shardFell(shard:Projectile):void
		{
			this.call(IShardObserver, "shardFellDown", shard);
		}
		internal function newInputPiece(isOn:Boolean, change:DCellXY):void
		{
			this.call(IInputObserver, "newInputPiece", isOn, change);
		}
		internal function actionRequested(action:int):void
		{
			this.call(IInputObserver, "actionRequested", action);
		}
		internal function showGameMap():void
		{
			this.call(IGameMapObserver, "showGameMap");
		}
		
		
		private function call(observerType:Class, method:String, ... args):void
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