package view.shell 
{
	import binding.IBinder;
	import controller.observers.ICollectibleObserver;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.layout.TiledColumnsLayout;
	import feathers.layout.TiledRowsLayout;
	import model.collectibles.Collectible;
	import model.interfaces.ICollectibles;
	import model.interfaces.ISave;
	import starling.display.Image;
	import starling.events.Event;
	import view.shell.controls.SingularMemory;
	import view.shell.events.ShellEvent;
	import view.themes.ShellTheme;
	import view.utils.createButton;
	
	internal class MemoriesScreen extends Screen implements ICollectibleObserver
	{
		private var collectibles:ICollectibles;
		private var save:ISave;
		
		
		private var body:ScrollContainer;
		
		public function MemoriesScreen(binder:IBinder) 
		{
			super();
			
			this.save = binder.save;
			this.collectibles = binder.collectibles;
			
			binder.notifier.addObserver(this);
			
			this.initializeBody();
			
			
			var quit:Button = createButton("BACK", ShellTheme.NAVIGATION_BUTTON);
			quit.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			this.addChild(quit);
		}
		
		private function initializeBody():void
		{
			this.body = new ScrollContainer();
			
			this.body.minWidth = View.WIDTH;
			this.body.minHeight = View.HEIGHT * 2 / 3;
			
			var layout:TiledColumnsLayout = new TiledColumnsLayout();
			
			layout.gap = 60;
			
			layout.horizontalAlign = TiledColumnsLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = TiledColumnsLayout.VERTICAL_ALIGN_BOTTOM;
			
			layout.tileHorizontalAlign = TiledColumnsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			layout.tileVerticalAlign = TiledColumnsLayout.TILE_VERTICAL_ALIGN_MIDDLE;
			
			layout.padding = 10;
			
			this.body.layout = layout;
			
			this.body.horizontalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			this.body.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			
			this.addChild(this.body);
		}
		
		
		override public function validate():void 
		{
			super.validate();
			
			this.body.removeChildren();
			
			for (var i:int = 0; i < Game.NUMBER_OF_COLLECTIBLES; i++)
			{
				var isUnlocked:Boolean = this.save.getCollectibleFound(i);
				
				this.body.addChild(new SingularMemory(i, isUnlocked));
			}
		}
		
		public function setCollectibleFound(collectible:Collectible):void
		{
			this.invalidate();
		}
		
		
		
		
		
		
		private function handleQuitTriggered():void
		{
			this.dispatchEventWith(ShellEvent.SHOW_MAIN);
		}
	}

}