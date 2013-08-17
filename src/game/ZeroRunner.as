package game 
{
	import game.achievements.AchievementsFeature;
	import game.broods.BroodsFeature;
	import game.input.InputManager;
	import game.items.ActorsFeature;
	import game.scene.SceneFeature;
	import game.statistics.StatisticsFeature;
	import game.time.Time;
	import game.ui.KeyboardControls;
	import game.ui.UIExtendsions;
	import game.utils.GameFoundations;
	import game.world.SearcherFeature;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.templates.UpdateGameBase;
	
	public class ZeroRunner extends UpdateGameBase
	{
		public static const flowName:String = "Game Flow";
		
		
		
		
		
		private var atlas:TextureAtlas;
		
		public function ZeroRunner(assets:AssetManager) 
		{			
			super(ZeroRunner.flowName);
			
			this.atlas = assets.getTextureAtlas("gameAtlas");
		}
		
		override protected function initializeFeatures():void
		{
			this.displayRoot.stage.color = 0;
			
			var foundations:GameFoundations = new GameFoundations
					(this, new Juggler(), this.atlas, new InputManager(this));
			
			new Time(this.displayRoot, foundations);
			
			var world:SearcherFeature = new SearcherFeature(foundations);
			new UIExtendsions(this);
			
			var broods:BroodsFeature = new BroodsFeature(foundations, world);
			
			new SceneFeature(this);
			new ActorsFeature(foundations, broods);
			
			new StatisticsFeature(this);
			new AchievementsFeature(this);
			
			this.dispatchUpdate(KeyboardControls.addKeyboardEventListenersTo, Starling.current.stage);
		}
	}

}