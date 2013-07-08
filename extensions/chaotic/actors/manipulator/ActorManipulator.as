package chaotic.actors.manipulator 
{
	import chaotic.actors.storage.ActorStorage;
	import chaotic.actors.storage.ISearcher;
	import chaotic.actors.storage.Puppet;
	import chaotic.informers.IGiveInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.updates.IUpdateListener;
	import chaotic.updates.IUpdateListenerAdder;
	import chaotic.updates.Update;
	import chaotic.xml.getActorsXML;
	import starling.animation.Juggler;
	
	public class ActorManipulator implements IUpdateListener, IActionPerformer
	{
		private var commandChains:Vector.<Vector.<ActionBase>>;
		private var onBlocked:Vector.<ActionBase>;
		private var onSpawned:Vector.<ActionBase>;
		private var onDamaged:Vector.<ActionBase>;
		
		private var storage:ActorStorage;
		
		private var updateFlow:IUpdateDispatcher;
		private var juggler:Juggler;
		
		public function ActorManipulator(newStorage:ActorStorage) 
		{
			this.storage = newStorage;
			
			
			var configuration:XML = getActorsXML();
			var numberOfTypes:int = int(configuration.actor.length());
			
			this.commandChains = new Vector.<Vector.<ActionBase>>(numberOfTypes, true);
			
			for (var i:int = 0; i < numberOfTypes; i++)
			{
				this.commandChains[i] = new Vector.<ActionBase>();
			}
			
			this.onBlocked = new Vector.<ActionBase>(numberOfTypes, true);
			this.onSpawned = new Vector.<ActionBase>(numberOfTypes, true);
			this.onDamaged = new Vector.<ActionBase>(numberOfTypes, true);
		}
		
		public function addListenersTo(storage:IUpdateListenerAdder):void
		{
			storage.addUpdateListener(this, "addActor");
			storage.addUpdateListener(this, "tick");
			storage.addUpdateListener(this, "getInformerFrom");
		}
		
		public function addActor(puppet:Puppet):void
		{
			var type:int = puppet.type;
			
			var numberOfCommands:int = this.commandChains[type].length;
			var commands:Vector.<ActionBase> = this.commandChains[type];
			
			for (var i:int = 0; i < numberOfCommands; i++)
			{
				commands[i].prepareDataIn(puppet);
			}
			
			this.onSpawned[type].actOn(puppet);
		}
		
		public function replaceActor(item:Puppet, change:DCellXY):void
		{
			this.storage.moveObject(item, change);
		}
		
		public function tick():void
		{
			var numberOfObjects:int = this.storage.getNumberOfObjects();
			
			for (var i:int = 0; i < numberOfObjects; i++)
			{
				var object:Puppet = this.storage.getObject(i);
				
				if (object.active)
				{
					var type:int = object.type;
					
					var numberOfCommands:int = this.commandChains[type].length;
					for (var k:int = 0; k < numberOfCommands; k++)
					{
						this.commandChains[type][k].actOn(object);
						
						if (!object.active)
						{
							numberOfObjects--;
							i--;
							break;
						}
					}
				}
				
				object.remainingDelay--;
			}
		}
		
		public function movedActor(item:Puppet, change:DCellXY, source:String):void
		{
			var id:int = item.id;
			
			if (source == "movedLikeACharacter")
				this.updateFlow.dispatchUpdate(new Update("movedLikeACharacter", id));
			
			if (id == 0)
				this.updateFlow.dispatchUpdate(new Update("moveCenter", change, item.speed));
			
			this.storage.moveObject(item, change);
			
			this.updateFlow.dispatchUpdate(new Update("moveActor", id, change, item.speed));
		}
		
		public function jumpedActor(item:Puppet, change:DCellXY):void
		{
			this.storage.moveObject(item, change, this.smash, item.getCell(), this.storage, this);
			
			item.remainingDelay = item.speed * 2;
			this.updateFlow.dispatchUpdate(new Update("jumpActor", item.id, change, item.speed * 2));
		}
		
		private function smash(cell:CellXY, storage:ISearcher, destroyer:IActionPerformer):void
		{
			var target:Puppet = storage.findObjectByCell(cell);
			if (target != null) destroyer.destroyActor(target);
		}
		
		public function destroyActor(item:Puppet):void
		{
			if (item.id == 0)
			{
				this.juggler.delayCall(this.updateFlow.dispatchUpdate, 0.5, new Update("gameOver"));
			}
			else
			{
				this.updateFlow.dispatchUpdate(new Update("actorRemoved", item.id));
			}
			
			this.storage.deleteObject(item);
		}
		
		public function blockedActor(item:Puppet, movingAttempt:DCellXY):void 
		{	
			this.onBlocked[item.type].actOn(item, movingAttempt);
		}
		
		public function damageActor(item:Puppet, damage:int):void
		{
			this.onDamaged[item.type].actOn(item, damage);
			
			item.hp -= damage;
			
			if (!(item.hp > 0))
			{
				this.destroyActor(item);
			}
		}
		
		public function detonateActor(item:Puppet):void
		{
			this.updateFlow.dispatchUpdate(new Update("detonateActor", item.id));
			
			this.destroyActor(item);
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			var configuration:XML = getActorsXML();
			var numberOfTypes:int = int(configuration.actor.length());
			
			var actions:ActionFactory = new ActionFactory();
			actions.getInformerFrom(table, this);
			
			var xml:XML = getActorsXML();
			
			for (var i:int = 0; i < numberOfTypes; i++)
			{
				var tmpNode:XMLList = xml.actor[i].configuration;
				var vector:Vector.<ActionBase> = this.commandChains[i];
				
				var length:int = tmpNode.action.length();
				
				for (var j:int = 0; j < length; j++)
				{
					vector.push(actions.getAction(tmpNode.action[j]));
				}
				
				this.onBlocked[i] = actions.getAction(xml.actor[i].onBlocked);
				this.onSpawned[i] = actions.getAction(xml.actor[i].onSpawned);
				this.onDamaged[i] = actions.getAction(xml.actor[i].onDamaged);
			}
			
			this.juggler = table.getInformer(Juggler);
			this.updateFlow = table.getInformer(IUpdateDispatcher);
		}
	}

}