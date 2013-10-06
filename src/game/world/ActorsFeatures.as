package game.world 
{
	import game.core.GameFoundations;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.world.clouds.Clouds;
	import game.world.items.BeaconLogic;
	import game.world.items.CharacterLogic;
	import game.world.items.JunkLogic;
	import game.world.items.TechnicLogic;
	import game.world.items.utils.ItemLogicBase;
	import game.world.items.utils.PointsOfInterest;
	import game.world.operators.ActorOperators;
	import game.world.renderer.Renderer;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	public class ActorsFeatures extends SceneFeatures implements IActorTracker, ISearcher
	{
		private var actors:Array;
		private var points:PointsOfInterest;
		
		private var width:int;
		
		private var foundations:GameFoundations;
		
		
		public function ActorsFeatures(foundations:GameFoundations) 
		{
			this.points = new PointsOfInterest();
			new Renderer(this, this.points, foundations, new Clouds(foundations));
			
			super(foundations.game);
			
			this.foundations = foundations;
			
			new ActorOperators(foundations, this.points);
			
			var flow:IUpdateDispatcher = foundations.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.technicUnlocked);
		}
		
		override update function prerestore():void
		{
			super.update::prerestore();
			
			var i:int;
			
			this.width = ((this.game).mapWidth + 2) * Game.SECTOR_WIDTH;
			this.actors = new Array();
			
			var intWidth:int = (this.game).mapWidth * Game.SECTOR_WIDTH;
			
			this.points.clearPointsOfInterest();
			
			new CharacterLogic(this.foundations, this.points);
			new BeaconLogic(this.foundations);
			
			for (i = 0; i < this.game.numberOfDroids; i++)
				new TechnicLogic(this.foundations, this.points);
			
			for (i = 0; i < this.game.numberOfJunks; i++)
				new JunkLogic(this.foundations, this.points);
		}
		
		public function findObjectByCell(x:int, y:int):ItemLogicBase
		{
			return this.actors[x + y * this.width];
		}
		
		
		public function addActor(actor:ItemLogicBase):void
		{
			this.actors[actor.x + actor.y * this.width] = actor;
		}
		
		public function moveActor(actor:ItemLogicBase, change:DCellXY):void
		{
			this.actors[actor.x - change.x + (actor.y - change.y) * this.width] = null;
			this.actors[actor.x + actor.y * this.width] = actor;
		}
		
		public function removeActor(actor:ItemLogicBase):void
		{
			this.actors[actor.x + actor.y * this.width] = null;
		}
		
		
		update function technicUnlocked(place:ICoordinated):void
		{
			var technic:TechnicLogic = new TechnicLogic(this.foundations, this.points);
			technic.moveTo(place);
		}
	}

}