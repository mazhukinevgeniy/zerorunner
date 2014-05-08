package model.items.character 
{
	import binding.IBinder;
	import model.interfaces.IInput;
	import model.interfaces.IScene;
	import model.items.Items;
	import model.items.MasterBase;
	import model.items.PuppetBase;
	import model.metric.CellXY;
	import model.metric.DCellXY;
	import model.status.StatusReporter;
	import model.utils.isCellSolid;
	
	public class CharacterMaster extends MasterBase
	{		
		private var input:IInput;
		private var scene:IScene;
		private var items:Items;
		
		private var status:StatusReporter;
		
		public function CharacterMaster(binder:IBinder, items:Items, status:StatusReporter) 
		{
			super(binder, items);
			
			this.status = status;
			this.input = binder.input;
			this.scene = binder.scene;
			this.items = items;
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			this.status.newHero(
				new Character(this, new CellXY(x, y), this._binder));
		}
		
		override protected function act(puppet:PuppetBase):void
		{
			var isStanding:Boolean = (puppet.occupation == Game.OCCUPATION_FREE);
			
			var tmp:Vector.<DCellXY> = this.input.getInputCopy();
			var action:DCellXY = tmp.pop();
			
			var x:int = puppet.x;
			var y:int = puppet.y;
			
			var next:int;
			
			//TODO: it's currently possible to shift movemode and move at the same turn; fix that
			
			if (isStanding)
			{
				while (action.x != 0 || action.y != 0)
				{
					if (!this.items.findAnyObjectByCell(x + action.x, y + action.y))
					{
						next = this.scene.getSceneCell(x + action.x, y + action.y);
						
						if (isCellSolid(next))
						{
							this.movePuppet(puppet, action);
							
							break;
						}
					}
					
					action = tmp.pop();
				}
			}
			
			if (!isCellSolid(this.scene.getSceneCell(puppet.x, puppet.y)))
			{
				puppet.tryDestruction();
			}
		}
	}

}