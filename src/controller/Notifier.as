package controller 
{
	import controller.interfaces.INotifier;
	import controller.observers.activity.IActivationObserver;
	import controller.observers.activity.IDeactivationObserver;
	import controller.observers.game.IGameFrameHandler;
	import controller.observers.game.IGameMenuRelated;
	import controller.observers.game.IGameStopHandler;
	import controller.observers.game.IInputObserver;
	import controller.observers.game.INewGameHandler;
	import controller.observers.game.IQuitGameHandler;
	import controller.observers.ISoundObserver;
	import controller.observers.map.IMapFrameHandler;
	import controller.observers.map.IMapStatusObserver;
	import controller.observers.projectiles.IShardObserver;
	import flash.utils.Dictionary;
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
				IActivationObserver, IDeactivationObserver,
				INewGameHandler, IQuitGameHandler,
				IGameFrameHandler, IGameStopHandler,
				IGameMenuRelated, IInputObserver,
				IMapFrameHandler, IMapStatusObserver,
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
		
		
		internal function processActivation():void
		{
			this.call(IActivationObserver, "processActivation");
		}
		internal function processDeactivation():void
		{
			this.call(IDeactivationObserver, "processDeactivation");
		}
		internal function setSoundMute(value:Boolean):void
		{
			this.call(ISoundObserver, "setSoundMute", value);
		}
		internal function setMusicMute(value:Boolean):void
		{
			this.call(ISoundObserver, "setMusicMute", value);
		}
		internal function setSoundValue(value:Number):void
		{
			this.call(ISoundObserver, "setSoundValue", value);
		}
		internal function setMusicValue(value:Number):void
		{
			this.call(ISoundObserver, "setMusicValue", value);
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
		internal function setVisibilityOfMenu(visible:Boolean):void
		{
			this.call(IGameMenuRelated, "setVisibilityOfMenu", visible);
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
		internal function setVisibilityOfMap(visible:Boolean):void
		{
			this.call(IMapStatusObserver, "setVisibilityOfMap", visible);
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