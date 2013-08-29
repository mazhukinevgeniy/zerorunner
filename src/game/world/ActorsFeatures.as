package game.world 
{
	import flash.events.Event;
	import game.utils.GameFoundations;
	import game.utils.metric.DCellXY;
	import game.world.broods.character.CharacterLogic;
	import game.world.broods.checkpoint.CheckpointLogic;
	import game.world.broods.fog.FogLogic;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.skyClearer.SkyClearerLogic;
	import game.world.broods.technic.TechnicLogic;
	import game.world.broods.utils.PointsOfInterest;
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
			new TechnicLogic(this.foundations, this.points);
			
			var i:int, goal:int;
			
			goal = (this.game).mapWidth * (this.game).mapWidth;
			for (i = 0; i < goal; i++)
				new CheckpointLogic(this.foundations);
			
			goal = this.width * this.width * 0.2;
			for (i = 0; i < goal; i++)
				new FogLogic(this.foundations);
			
			goal = intWidth * intWidth * 0.04;
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