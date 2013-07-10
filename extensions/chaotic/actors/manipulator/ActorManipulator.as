package chaotic.actors.manipulator 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.actors.storage.ActorStorage;
	import chaotic.actors.storage.ISearcher;
	import chaotic.actors.storage.Puppet;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.game.ChaoticGame;
	import chaotic.informers.IGiveInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import starling.animation.Juggler;
	
	public class ActorManipulator implements IActionPerformer
	{
		private var commandChains:Vector.<Vector.<ActionBase>>;
		private var onSpawned:Vector.<ActionBase>;
		private var onDamaged:Vector.<ActionBase>;
		
		private var storage:ActorStorage;
		
		private var updateFlow:IUpdateDispatcher;
		private var juggler:Juggler;
		
		public function ActorManipulator(newStorage:ActorStorage, flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.addActor);
			flow.addUpdateListener(ChaoticGame.tick);
			flow.addUpdateListener(ChaoticGame.getInformerFrom);
			
			this.updateFlow = flow;
			
			this.storage = newStorage;
			
			
			var configuration:XML = ActorsFeature.CONFIG;
			var numberOfTypes:int = int(configuration.actor.length());
			
			this.commandChains = new Vector.<Vector.<ActionBase>>(numberOfTypes, true);
			
			for (var i:int = 0; i < numberOfTypes; i++)
			{
				this.commandChains[i] = new Vector.<ActionBase>();
			}
			
			this.onSpawned = new Vector.<ActionBase>(numberOfTypes, true);
			this.onDamaged = new Vector.<ActionBase>(numberOfTypes, true);
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
							break;
						}
					}
				}
				
				object.remainingDelay--;
			}
		}
		
		public function movedActor(item:Puppet, change:DCellXY):void
		{
			var id:int = item.id;
			
			if (id == 0)
				this.updateFlow.dispatchUpdate(ActorsFeature.moveCenter, change, item.speed);
			
			this.storage.moveObject(item, change);
			
			this.updateFlow.dispatchUpdate(ActorsFeature.moveActor, id, change, item.speed);
		}
		
		public function jumpedActor(item:Puppet, change:DCellXY):void
		{
			this.storage.moveObject(item, change, this.smash, item.getCell(), this.storage, this);
			
			item.remainingDelay = item.speed * 2;
			this.updateFlow.dispatchUpdate(ActorsFeature.jumpActor, item.id, change, item.speed * 2);
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
				this.juggler.delayCall(this.updateFlow.dispatchUpdate, 0.5, ChaoticGame.gameOver);
			}
			else
			{
				this.updateFlow.dispatchUpdate(ActorsFeature.actorRemoved, item.id);
				
				this.storage.deleteObject(item);
			}
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
			this.updateFlow.dispatchUpdate(ActorsFeature.detonateActor, item.id);
			
			this.destroyActor(item);
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			var configuration:XML = ActorsFeature.CONFIG;
			var numberOfTypes:int = int(configuration.actor.length());
			
			var actions:ActionFactory = new ActionFactory(this.updateFlow);
			actions.getInformerFrom(table, this);
			
			for (var i:int = 0; i < numberOfTypes; i++)
			{
				var tmpNode:XMLList = configuration.actor[i].configuration;
				var vector:Vector.<ActionBase> = this.commandChains[i];
				
				var length:int = tmpNode.action.length();
				
				for (var j:int = 0; j < length; j++)
				{
					vector.push(actions.getAction(tmpNode.action[j]));
				}
				
				this.onSpawned[i] = actions.getAction(configuration.actor[i].onSpawned);
				this.onDamaged[i] = actions.getAction(configuration.actor[i].onDamaged);
			}
			
			this.juggler = table.getInformer(Juggler);
		}
	}

}