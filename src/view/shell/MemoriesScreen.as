package view.shell 
{
	import binding.IBinder;
	import controller.observers.ICollectibleObserver;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.core.FeathersControl;
	import feathers.layout.TiledColumnsLayout;
	import feathers.layout.TiledRowsLayout;
	import model.collectibles.Collectible;
	import model.interfaces.ICollectibles;
	import model.interfaces.ISave;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;
	import view.shell.controls.SingularMemory;
	import view.shell.events.ShellEvent;
	import view.themes.ShellTheme;
	import view.utils.createButton;
	
	internal class MemoriesScreen extends Screen implements ICollectibleObserver
	{
		private var collectibles:ICollectibles;
		private var save:ISave;
		
		private var atlas:TextureAtlas;
		
		private var body:LayoutGroup;
		
		public function MemoriesScreen(binder:IBinder) 
		{
			super();
			
			this.save = binder.save;
			this.collectibles = binder.collectibles;
			
			this.atlas = binder.assetManager.getTextureAtlas(View.MAIN_ATLAS);
			
			binder.notifier.addObserver(this);
			
			this.initializeBody();
			
			
			var quit:Button = createButton("BACK", ShellTheme.NAVIGATION_BUTTON);
			quit.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			this.addChild(quit);
		}
		
		private function initializeBody():void
		{
			this.body = new LayoutGroup();
			
			this.body.minWidth = this.body.maxWidth = View.WIDTH;
			this.body.maxHeight = this.body.minHeight = 
				4 * View.MEMORY_VIEW_WIDTH + 32;
			
			var layout:TiledColumnsLayout = new TiledColumnsLayout();
			
			layout.gap = 10;
			
			layout.horizontalAlign = TiledColumnsLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = TiledColumnsLayout.VERTICAL_ALIGN_BOTTOM;
			
			layout.tileHorizontalAlign = TiledColumnsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
			layout.tileVerticalAlign = TiledColumnsLayout.TILE_VERTICAL_ALIGN_MIDDLE;
			
			layout.padding = 1;
			
			this.body.layout = layout;
			
			this.addChild(this.body);
		}
		
		
		override public function validate():void 
		{
			super.validate();
			
			this.body.removeChildren();
			
			for (var i:int = 0; i < Game.NUMBER_OF_COLLECTIBLES; i++)
			{
				var isUnlocked:Boolean = this.save.getCollectibleFound(i);
				
				this.createMemory(i, isUnlocked)
			}
		}
		
		private function createMemory(type:int, isUnlocked:Boolean):void
		{
			var mem:SingularMemory = new SingularMemory(type);
			
			var skin:Image = new Image(this.atlas.getTexture("memory_0"));
			skin.scaleX = skin.scaleY = View.MEMORY_VIEW_WIDTH / skin.width;
			
			mem.addChild(skin);
			
			if (isUnlocked)
			{
				
			}
			else
			{
				mem.alpha *= 0.5;
			}
			
			this.body.addChild(mem);
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