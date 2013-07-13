		public function ActorSpawner(actorStorage:ActorStorage, flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.restore);
			flow.addUpdateListener(ZeroRunner.tick);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			this.updateFlow = flow;
			
			this.storage = actorStorage;
			
			var actors:XML = ActorsFeature.CONFIG;
			var numberOfTypes:int = actors.actor.length();
			this.speeds = new Vector.<int>(numberOfTypes, true);
			this.hitpoints = new Vector.<int>(numberOfTypes, true);
			this.chances = new Vector.<Number>(numberOfTypes, true);
			this.getCell = new Vector.<String>(numberOfTypes, true);
			
			for (var i:int = 0; i < numberOfTypes; i++)
			{
				var actor:XML = actors.actor[i];
				
				this.speeds[i] = int(actor.speed);
				this.hitpoints[i] = int(actor.baseHP);
				this.chances[i] = Number(actor.chance);
				this.getCell[i] = String(actor.getCell);
			}
			this.chances[numberOfTypes - 1] = 1;
			
			this.numberOfTypes = numberOfTypes;
		}
		
		public function restore():void
		{
			var cell:CellXY = this.getSpawnCell();
			
			var newPuppet:Puppet = new Puppet(0, 0, cell);
			newPuppet.speed = this.speeds[0];
			newPuppet.hp = this.hitpoints[0];
			
			this.updateFlow.dispatchUpdate(ActorsFeature.actorAdded, newPuppet);
			this.updateFlow.dispatchUpdate(ActorsFeature.setCenter, cell);
		}
		
		public function tick():void
		{
			var actorsToSpawn:int = ActorsFeature.CAP - this.storage.getNumberOfActives();
			var stepsToDo:int = Math.min(ActorsFeature.MAX_SPAWN_ONCE, actorsToSpawn);
			
			for (var i:int = 0; i < stepsToDo; i++)
				this.spawn(this.storage.getUnusedID(), 
		                   this.getType());
		}
		
		private function spawn(id:int, type:int):void
		{
			var cell:CellXY = this[getCell[type]]();
			var char:CellXY = this.storage.getCharacterCell();
			
			if ((Metric.distance(cell, char) > 10) && 
				   (this.scene.getSceneCell(cell) != SceneFeature.FALL) &&
				   (this.storage.findObjectByCell(cell) == null))
			{
				var newPuppet:Puppet = new Puppet(id, type, cell);
				newPuppet.speed = this.speeds[type];
				newPuppet.hp = this.hitpoints[type];
				
				this.updateFlow.dispatchUpdate(ActorsFeature.actorAdded, newPuppet);
			}
			else this.storage.addUnusedID(id);
		}
		
		private function getSpawnCell():CellXY
		{
			return ActorsFeature.SPAWN_CELL;
		}
		private function getGrindedCell():CellXY
		{
			var y:int = this.storage.getCharacterCell().y - 20 + Math.random() * 40;
			
			var x:int = this.grinders.getFront(y);
			
			return new CellXY(x, y);
		}
		private function getRandomCell():CellXY
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