package game.actors.manipulator 
{
	import game.actors.ActorsFeature;
	import game.actors.storage.ActorStorage;
	import game.actors.storage.ISearcher;
	import game.actors.storage.Puppet;
	import game.ZeroRunner;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	
	public class ActorManipulator
	{
		private var commandChains:Vector.<Vector.<ActionBase>>;
		
		private var updateFlow:IUpdateDispatcher;
		private var storage:ActorStorage;
		
		public function ActorManipulator(newStorage:ActorStorage, flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.actorAdded);
			flow.addUpdateListener(ZeroRunner.tick);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			this.updateFlow = flow;
			
			this.storage = newStorage;
			
			
			var configuration:XML = ActorsFeature.CONFIG;
			var numberOfTypes:int = int(configuration.actor.length());
			
			this.commandChains = new Vector.<Vector.<ActionBase>>(numberOfTypes, true);
			
			for (var i:int = 0; i < numberOfTypes; i++)
			{
				this.commandChains[i] = new Vector.<ActionBase>();
			}
		}
		
		public function actorAdded(puppet:Puppet):void
		{
			var type:int = puppet.type;
			
			var numberOfCommands:int = this.commandChains[type].length;
			var commands:Vector.<ActionBase> = this.commandChains[type];
			
			for (var i:int = 0; i < numberOfCommands; i++)
			{
				commands[i].prepareDataIn(puppet);
			}
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
		
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			var configuration:XML = ActorsFeature.CONFIG;
			var numberOfTypes:int = int(configuration.actor.length());
			
			var actions:ActionFactory = new ActionFactory(this.updateFlow);
			actions.getInformerFrom(table);
			
			for (var i:int = 0; i < numberOfTypes; i++)
			{
				var tmpNode:XMLList = configuration.actor[i].configuration;
				var vector:Vector.<ActionBase> = this.commandChains[i];
				
				var length:int = tmpNode.action.length();
				
				for (var j:int = 0; j < length; j++)
				{
					vector.push(actions.getAction(tmpNode.action[j]));
				}
			}
		}
	}

}