package game.items 
{
	import data.viewers.GameConfig;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.base.ItemLogicBase;
	import game.items.beacon.Beacon;
	import game.items.character.Character;
	import game.items.junk.Junk;
	import game.items.technic.Technic;
	import game.items.utils.ActorUtils;
	import utils.updates.update;
	
	public class ActorsFeatures implements IActors, IActorTracker
	{
		private var actors:Array;
		private var width:int;
		
		
		
		public function ActorsFeatures(foundations:GameElements) 
		{
			new ActorUtils(this, foundations.flow, foundations.pointsOfInterest);
			
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