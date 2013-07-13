package game.actors.manipulator 
{
	import game.actors.ActorsFeature;
	import game.ZeroRunner;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	
	public class ActorManipulator
	{
		
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
			
			this.actions = new Vector.<Vector.<ActionBase>>(numberOfTypes, true);
			this.checks = new Vector.<Vector.<ActionBase>>(numberOfTypes, true);
			
			for (var i:int = 0; i < numberOfTypes; i++)
			{
				this.actions[i] = new Vector.<ActionBase>();
				this.checks[i] = new Vector.<ActionBase>();
			}
		}
		
		public function actorAdded(puppet:Puppet):void
		{
			var type:int = puppet.type;
			
			var actions:Vector.<ActionBase> = this.actions[type];
			var numberOfCommands:int = actions.length;
			
			for (var i:int = 0; i < numberOfCommands; i++)
			{
				actions[i].prepareDataIn(puppet);
			}
		}
		
		public function tick(numberOfObjects:int):void
		{
			var numberOfObjects:int = this.storage.getNumberOfObjects();
			var checks:Vector.<ActionBase>;
			var actions:Vector.<ActionBase>;
			
			
			for (var i:int = 0; i < numberOfObjects; i++)
			{
				var object:Puppet = this.storage.getObject(i);
				
				if (object.active)
					
			}
		}
		
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			var configuration:XML = ActorsFeature.CONFIG;
			var numberOfTypes:int = int(configuration.actor.length());
			
			var actions:ActionFactory = new ActionFactory(this.updateFlow);
			actions.getInformerFrom(table);
			
			var tmpNode:XMLList;
			var j:int;
			
			for (var i:int = 0; i < numberOfTypes; i++)
			{
				tmpNode = configuration.actor[i].configuration;
				
				var actionsV:Vector.<ActionBase> = this.actions[i];
				var checksV:Vector.<ActionBase> = this.checks[i];
				
				var lengthA:int = tmpNode.action.length();
				var lengthC:int = tmpNode.check.length();
				
				for (j = 0; j < lengthA; j++)
				{
					actionsV.push(actions.getAction(tmpNode.action[j]));
				}
				for (j = 0; j < lengthC; j++)
				{
					checksV.push(actions.getAction(tmpNode.check[j]));
				}
			}
		}
	}

}