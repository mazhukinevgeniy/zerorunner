package view.shell 
{
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import feathers.controls.ScrollContainer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	internal class Windows implements INewGameHandler, IQuitGameHandler
	{
		public static const GAME:int = 0;
		public static const ACHIEVEMENTS:int = 1;
		public static const SETTINGS:int = 2;
		public static const CREDITS:int = 3;
		
		public static const NUMBER_OF_WINDOWS:int = 4;
		
		
		private static const UNDETERMINED:int = -1;
		
		private var windows:Vector.<DisplayObject>;
		
		private var idLastOpenedWindow:int;
		
		public function Windows(windows:Vector.<DisplayObject>, binder:IBinder) 
		{
			this.windows = windows;
			
			this.idLastOpenedWindow = Windows.UNDETERMINED;
			
			
			binder.notifier.addObserver(this);
		}
		
		public function newGame():void
		{
			this.toggleWindow(Windows.GAME);
		}
		
		public function quitGame():void
		{
			this.windows[Windows.GAME].visible = false;
			
			this.idLastOpenedWindow = Windows.UNDETERMINED;
		}
		
		internal function toggleWindow(idTarget:int):void
		{
			this.closelastOpenedWindow();
			
			if (idTarget != this.idLastOpenedWindow)
			{
				this.windows[idTarget].visible = true;
				this.idLastOpenedWindow = idTarget;
			}
			else
			{
				this.idLastOpenedWindow = Windows.UNDETERMINED;
			}
		}
		
		private function closelastOpenedWindow():void
		{
			if (this.idLastOpenedWindow != Windows.UNDETERMINED)
				this.windows[this.idLastOpenedWindow].visible = false;
		}		
	}

}