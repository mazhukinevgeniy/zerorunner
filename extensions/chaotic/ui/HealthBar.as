package chaotic.ui 
{
	import chaotic.core.ChaoticFeature;
	import chaotic.updates.IRestorable;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.xml.getActorsXML;
	import starling.display.Image;
	import starling.display.Sprite;
	
	internal class HealthBar extends ChaoticFeature implements IRestorable
	{
		private var container:Sprite;
		
		private var points:Vector.<Image>;
		private var healthPoints:int;
		
		public function HealthBar() 
		{
			this.container = new Sprite();
			
			
		}
		
		// TODO: handle onDamaged somehow
		
		public function restore():void
		{
			this.healthPoints = int(getActorsXML().actor[0].baseHP);
			
			this.container.removeChildren();
			
			this.points = new Vector.<Image>();
			
			for (var i:int = 0; i < this.healthPoints; i++)
			{
				//TODO : generate hp sprites, add them as childs and to the vector
			}
		}
		
		
		override public function setUpdateFlow(item:IUpdateDispatcher):void
		{
			super.setUpdateFlow(item);
			
			this.dispatchUpdate(new Update("addToTheHUD", this.container));
		}
		
	}

}