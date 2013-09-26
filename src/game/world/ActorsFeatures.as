package game.world 
{
	import flash.events.Event;
	import game.core.GameFoundations;
	import game.core.metric.DCellXY;
	import game.world.items.character.CharacterLogic;
	import game.world.items.checkpoint.CheckpointLogic;
	import game.world.items.ItemLogicBase;
	import game.world.items.skyClearer.SkyClearerLogic;
	import game.world.items.technic.TechnicLogic;
	import game.world.items.utils.PointsOfInterest;
	import game.world.items.wormholes.WormholeLogic;
	import game.world.operators.ActorOperators;
	import game.world.renderer.Renderer;
	import starling.core.Starling;
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
			new Renderer(this, this.points, foundations);
			
			super(foundations.game);
			
			this.foundations = foundations;
			
			new ActorOperators(foundations, this.points);
			
			var flow:IUpdateDispatcher = foundations.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			
			flow.workWithUpdateListener(CheckpointLogic);
			flow.addUpdateListener(Update.prerestore);
			
			Starling.current.nativeStage.addEventListener(Event.DEACTIVATE, this.handleFocusChange);
		}
		
		private function handleFocusChange(event:Event):void
		{
			this.foundations.flow.dispatchUpdate(Update.discardInput);
		}
		
		override update function prerestore():void
		{
			super.update::prerestore();
			
			this.width = ((this.game).mapWidth + 2) * Game.SECTOR_WIDTH;
			this.actors = new Array();
			
			var intWidth:int = (this.game).mapWidth * Game.SECTOR_WIDTH;
			
			this.points.clearPointsOfInterest();
			
			new CharacterLogic(this.foundations, this.points);
			new TechnicLogic(this.foundations, this.points); //TODO: parametrize
			new WormholeLogic(this.foundations);
			
			var i:int, goal:int;
			
			goal = (this.game).mapWidth * (this.game).mapWidth;
			for (i = 0; i < goal; i++)
				new CheckpointLogic(this.foundations);
			
			goal = intWidth * intWidth * 0.04; //TODO: parametrize
			for (i = 0; i < goal; i++)
				new SkyClearerLogic(this.foundations);
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
	}

}