package game 
{
	import game.hud.UIExtendsions;
	import game.utils.achievements.AchievementsFeature;
	import game.utils.GameFoundations;
	import game.utils.input.InputManager;
	import game.utils.statistics.StatisticsFeature;
	import game.utils.time.Time;
	import game.world.broods.BroodsFeature;
	import game.world.cache.ActorsFeature;
	import game.world.cache.SceneFeature;
	import game.world.cache.SearcherFeature;
	import game.world.sectors.SectorsFeature;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.templates.UpdateGameBase;
	
	public class ZeroRunner extends UpdateGameBase implements IGame
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
			
			new SectorsFeature(foundations);
			
			this.dispatchUpdate(Update.addKeyboardEventListenersTo, Starling.current.stage);
		}
		
		public function getMapWidth():int
		{
			return 3;
		}
	}

}