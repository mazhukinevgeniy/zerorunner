package game.world 
{
	import game.utils.GameFoundations;
	import game.world.broods.character.Character;
	import game.world.broods.checkpoint.Checkpoint;
	import game.world.broods.fog.Fog;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.skyClearer.SkyClearer;
	import game.world.broods.technic.Technic;
	import game.world.broods.utils.PointsOfInterest;
	import game.world.operators.ActorOperators;
	import game.world.renderer.Renderer;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	public class ActorsFeatures extends SceneFeatures implements ISearcher
	{
		private var actors:Vector.<ItemLogicBase>;
		private var points:PointsOfInterest;
		
		private var foundations:GameFoundations;
		
		
		public function ActorsFeatures(foundations:GameFoundations) 
		{
			this.points = new PointsOfInterest();
			new Renderer(this, this.points, foundations);
			
			super(foundations.game);
			
			this.foundations = foundations;
			
			new ActorOperators(foundations.flow);
			
			var flow:IUpdateDispatcher = foundations.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
		}
		
		override update function prerestore():void
		{
			super.update::prerestore();
			
			this.points.clearPointsOfInterest();
			
			//TODO: clean the cache...
			
			
			new Character(this.foundations, this, this.points);
			new Checkpoint(this.foundations, this);
			new Fog(this.foundations, this);
			new SkyClearer(this.foundations, this, this.points);
			new Technic(this.foundations, this, this.points);
		}
		
		public function findObjectByCell(x:int, y:int):ItemLogicBase
		{
			return null;
			
			//TODO: implement
		}
	}

}