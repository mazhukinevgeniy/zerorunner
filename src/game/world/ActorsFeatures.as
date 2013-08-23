package game.world 
{
	import flash.events.Event;
	import game.utils.GameFoundations;
	import game.utils.metric.DCellXY;
	import game.world.broods.character.Character;
	import game.world.broods.checkpoint.Checkpoint;
	import game.world.broods.fog.Fog;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.skyClearer.SkyClearer;
	import game.world.broods.technic.Technic;
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
			
			new ActorOperators(foundations.flow, this, this.points);
			
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
			
			this.width = ((this.game).getMapWidth() + 2) * Game.SECTOR_WIDTH;
			this.actors = new Array();
			
			this.points.clearPointsOfInterest();
			
			
			
			new Character(this.foundations, this.points);
			new Checkpoint(this.foundations);
			new Fog(this.foundations);
			new SkyClearer(this.foundations);
			new Technic(this.foundations, this.points);
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