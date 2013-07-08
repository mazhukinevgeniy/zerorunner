package view 
{
	import controller.IController;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureAtlas;
	import starling.utils.adaptTextureAtlasMakerXML;
	import starling.utils.AssetManager;
	import view.controls.ButtonGlobalNavigation;
	import view.controls.MuteButton;
	import view.events.MainMenuEvent;
	import view.events.NavigationEvent;
	import view.events.PanelEvent;
	import view.panel.Panel;
	import view.screens.Background;
	import view.sounds.SoundManager;
	import view.sounds.MusicManager;
	import view.windows.play.MainMenu;
	
	
	
	public class View extends Sprite implements IView
	{
		[Embed(source="../../res/assets/fonts/HiLoDeco.ttf", embedAsCFF="false", fontFamily="HiLo-Deco")]
		private static const HiLoDeco:Class;
		
		
		
		
		[Embed(source = "../../res/assets/textures/atlases/gameatlas.xml", mimeType="application/octet-stream")]
		internal static const gameatlas:Class; 
		
		
		private var assets:AssetManager;
		
		
		private var controller:IController;
		
		private var background:Background;
		
		private var windows:Array;
		
		private var music:MusicManager;
		private var sound:SoundManager;
		
		private var muteButton:MuteButton;
		
		private var game:Sprite;
		private var panel:Panel;
		private var gameView:Sprite;
		
		private var assetsLoaded:Boolean;
		
		public function View() 
		{
			this.game = new Sprite();
			this.game.addChild(this.gameView = new Sprite());
			
			
			this.assets = new AssetManager();
			
			this.assets.verbose = true;
			this.assets.enqueue(EmbeddedAssets);
			
			this.assets.loadQueue(this.continueConstruction);
			
			this.addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
			
		}
		
		private function handleAddedToStage():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function continueConstruction(ratio:Number):void
		{
			if (ratio == 1.0)
			{
				this.assetsLoaded = true;
				if (this.controller != null)
					this.initializeStuff();
			}
		}
		
		
		public function setController(item:IController):void
		{
			this.controller = item;
			if (this.assetsLoaded)
				this.initializeStuff();
		}
		
		private function initializeStuff():void
		{
			this.removeChildren();
			
			this.assets.addTextureAtlas("gameAtlas", new TextureAtlas(this.assets.getTexture("sprites0"), adaptTextureAtlasMakerXML(View.gameatlas)));
			
			this.background = new Background();
			this.addChild(this.background);
			
			this.game.addChild(this.panel = new Panel());
			this.addEventListener(PanelEvent.BACK_TO_MENU, this.handlePanelEvent);
			this.addEventListener(PanelEvent.ROLL_OUT, this.handlePanelEvent);
			this.addEventListener(PanelEvent.ROLL_OVER, this.handlePanelEvent);
			
			this.addChild(new ButtonGlobalNavigation(10, "Play"));
			this.addEventListener("Play", this.handleNavigationEvent);
			
			this.addChild(this.game); this.game.visible = false;
			
			
			this.music = new MusicManager(this.assets);
			this.music.playMusic();
			this.sound = new SoundManager(this.assets);
			
			this.addChild(this.muteButton = new MuteButton());
			this.muteButton.addEventListener(starling.events.Event.TRIGGERED, this.handleTrigger);
			
			
			this.windows = new Array();
			this.addChild(this.windows[0] = new MainMenu(this.assets));
			this.addEventListener(MainMenuEvent.NEW_GAME, this.handleMainMenuEvent);
			this.addEventListener(MainMenuEvent.CLOSE, this.handleMainMenuEvent);
			
			this.addEventListener(TouchEvent.TOUCH, this.handleTouch);
			
			Starling.current.showStats = true;
			
			(this.controller).viewPrepared();
		}
		
		private function handleTrigger(event:Event):void
		{
			this.toggleSound();
		}
		
		private function handleNavigationEvent(event:NavigationEvent):void
		{
			(this.controller).handleNavigationEvent(event);
		}
		
		private function handleMainMenuEvent(event:MainMenuEvent):void
		{
			(this.controller).handleMainMenuEvent(event);
		}
		
		private function handlePanelEvent(event:PanelEvent):void
		{
			(this.controller).handlePanelEvent(event);
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			(this.controller).keyUp(event);
		}
		
		
		public function showGame():void
		{
			this.game.visible = true;
		}
		public function hideGame():void
		{
			this.game.visible = false;
		}
		
		public function showPanel():void
		{
			this.panel.expand();
		}
		public function hidePanel():void
		{
			this.panel.collapse();
		}
		
		
		public function toggleWindow(id:int):void
		{
			this.windows[id].visible = !this.windows[id].visible;
		}
		
		public function toggleSound():void
		{
			this.music.toggleSound();
			this.sound.toggleSound();
			this.muteButton.toggleTitle();
		}
		
		
		
		private function handleTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this); 
			
			if (touch && (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.BEGAN))
			{
				(this.controller).focusIn();
			}
		}
		
		public function getGameContainer():Sprite
		{
			return this.gameView;
		}
		public function getAssets():AssetManager
		{
			return this.assets;
		}
	}

}