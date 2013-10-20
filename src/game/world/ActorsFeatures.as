package game.world 
{
	import data.viewers.GameConfig;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.world.items.beacon.Beacon;
	import game.world.items.beacon.BeaconLogic;
	import game.world.items.character.Character;
	import game.world.items.character.CharacterLogic;
	import game.world.items.ItemLogicBase;
	import game.world.items.junk.Junk;
	import game.world.items.junk.JunkLogic;
	import game.world.items.PointsOfInterest;
	import game.world.items.technic.Technic;
	import game.world.items.technic.TechnicLogic;
	import game.world.operators.ActorOperators;
	import utils.updates.update;
	
	public class ActorsFeatures implements IActors, IActorTracker
	{
		private var actors:Array;
		private var width:int;
		
		
		
		public function ActorsFeatures(foundations:GameElements) 
		{
			new ActorOperators(this, foundations.flow, foundations.pointsOfInterest);
			
			foundations.flow.workWithUpdateListener(this);
			foundations.flow.addUpdateListener(Update.prerestore);
			foundations.flow.addUpdateListener(Update.quitGame);
			
			new Character(foundations);
			new Beacon(foundations);
			new Technic(foundations);
			new Junk(foundations);
		}
		
		
		update function prerestore(config:GameConfig):void
		{
			this.width = config.width + 2 * Game.BORDER_WIDTH;
			this.actors = new Array();
		}
		
		update function quitGame():void
		{
			this.actors = null;
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