package chaotic.actors.spawner 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.actors.storage.ActorStorage;
	import chaotic.actors.storage.Puppet;
	import chaotic.choosenArea.IChoosenArea;
	import chaotic.errors.UnresolvedRequestError;
	import chaotic.informers.IGiveInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import chaotic.scene.IScene;
	import chaotic.scene.SceneFeature;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.updates.IUpdateListener;
	import chaotic.updates.IUpdateListenerAdder;
	import chaotic.updates.Update;
	import chaotic.xml.getActorsXML;
	
	public class ActorSpawner implements IUpdateListener
	{
		private var scene:IScene;
		private var choosenArea:IChoosenArea;
		
		private var storage:ActorStorage;
		
		private var speeds:Vector.<int>;
		private var hitpoints:Vector.<int>;
		private var chances:Vector.<Number>;
		
		private var numberOfTypes:int;
		
		private var updateFlow:IUpdateDispatcher;
		
		public function ActorSpawner(actorStorage:ActorStorage)
		{
			this.storage = actorStorage;
			
			var actors:XML = getActorsXML();
			var numberOfTypes:int = actors.actor.length();
			this.speeds = new Vector.<int>(numberOfTypes, true);
			this.hitpoints = new Vector.<int>(numberOfTypes, true);
			this.chances = new Vector.<Number>(numberOfTypes, true);
			
			for (var i:int = 0; i < numberOfTypes; i++)
			{
				this.speeds[i] = int(actors.actor[i].speed);
				this.hitpoints[i] = int(actors.actor[i].baseHP);
				this.chances[i] = Number(actors.actor[i].chance);
			}
			this.chances[numberOfTypes - 1] = 1;
			
			this.numberOfTypes = numberOfTypes;
		}
		
		public function addListenersTo(storage:IUpdateListenerAdder):void
		{
			storage.addUpdateListener(this, "restore");
			storage.addUpdateListener(this, "tick");
			storage.addUpdateListener(this, "getInformerFrom");
		}
		
		public function restore():void
		{
			var cell:CellXY = ActorsFeature.SPAWN_CELL;
			
			var newPuppet:Puppet = new Puppet(0, 0, cell);
			newPuppet.speed = this.speeds[0];
			newPuppet.hp = this.hitpoints[0];
			
			this.updateFlow.dispatchUpdate(new Update("addActor", newPuppet));
			this.updateFlow.dispatchUpdate(new Update("setCenter", cell));
		}
		
		public function tick():void
		{
			var actorsToSpawn:int = ActorsFeature.CAP - this.storage.getNumberOfActives();
			var stepsToDo:int = Math.min(ActorsFeature.MAX_SPAWN_ONCE, actorsToSpawn);
			
			for (var i:int = 0; i < stepsToDo; i++)
				this.spawn(this.storage.getUnusedID(), 
		                   this.getType(), 
						   this.getCell());
			
			CONFIG::debug
			{
				trace(this.storage.getNumberOfActives(), "actors are present");
			}
		}
		
		private function spawn(id:int, type:int, cell:CellXY):void
		{
			var char:CellXY = this.storage.getCharacterCell();
			
			if ((Metric.distance(cell, char) > 10) && 
				   (this.scene.getSceneCell(cell) != SceneFeature.FALL) &&
				   (this.storage.findObjectByCell(cell) == null))
			{
				var newPuppet:Puppet = new Puppet(id, type, cell);
				newPuppet.speed = this.speeds[type];
				newPuppet.hp = this.hitpoints[type];
				
				this.updateFlow.dispatchUpdate(new Update("addActor", newPuppet));
			}
			else this.storage.addUnusedID(id);
		}
		
		private function getCell():CellXY
		{
			return this.storage.getCharacterCell().applyChanges
					(new DCellXY( -5 + Math.random() * 15, -8 + Math.random() * 21));
		}
		private function getType():int
		{
			for (var i:int = 0; i < this.numberOfTypes; i++)
				if (Math.random() < this.chances[i])
					return i;
			throw new UnresolvedRequestError();
		}
		
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.scene = table.getInformer(IScene);
			this.choosenArea = table.getInformer(IChoosenArea);
			
			this.updateFlow = table.getInformer(IUpdateDispatcher);
		}
	}

}