package view 
{
	import chaotic.core.Chaotic;
	import controller.IController;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
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
	
	
	public class View extends Chaotic implements IView
	{
		[Embed(source="../../res/assets/fonts/HiLoDeco.ttf", embedAsCFF="false", fontFamily="HiLo-Deco")]
		private static const HiLoDeco:Class;
		
		[Embed(source = "../../res/assets/textures/atlases/gameatlas.xml", mimeType="application/octet-stream")]
		internal static const gameatlas:Class; 
		
		private var assets:AssetManager;
		
		
		
		public function View(displayRoot:DisplayObjectContainer) 
		{
			super();
			
			this.game = new Sprite();
			this.game.addChild(this.gameView = new Sprite());
			
			displayRoot.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		override protected function addFeatures():void
		{
			this.assets = new AssetManager();
			
			this.assets.verbose = true;
			this.assets.enqueue(EmbeddedAssets);
			
			this.assets.loadQueue(this.continueConstruction);
		}
		
		private function continueConstruction(ratio:Number):void
		{
			if (ratio == 1.0)
			{
				this.initializeStuff();
			}
		}
		
		private function initializeStuff():void
		{
			this.removeChildren();
			
			this.assets.addTextureAtlas("gameAtlas", new TextureAtlas(this.assets.getTexture("sprites0"), adaptTextureAtlasMakerXML(View.gameatlas)));
			
			this.background = new Background();			
			this.game.addChild(this.panel = new Panel());
			
			this.addChild(new ButtonGlobalNavigation(30, "Play"));
			
			this.addChild(this.game); this.game.visible = false;
			
			this.music = new MusicManager(this.assets);
			this.music.playMusic();
			this.sound = new SoundManager(this.assets);
			
			this.addChild(this.muteButton = new MuteButton());
			
			this.windows = new Array();
			this.addChild(this.windows[0] = new MainMenu(this.assets));
			
			(this.controller).viewPrepared();
		}
		
		public function toggleSound():void
		{
			this.music.toggleSound();
			this.sound.toggleSound();
			this.muteButton.toggleTitle();
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