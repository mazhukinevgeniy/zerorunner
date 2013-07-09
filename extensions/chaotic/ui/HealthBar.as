package chaotic.ui 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import chaotic.xml.getActorsXML;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	internal class HealthBar 
	{
		private const POINTS_PER_COLUMN:int = 5;
		
		
		private var container:Sprite;
		
		private var points:Vector.<Quad>;
		private var healthPoints:int;
		
		public function HealthBar(flow:IUpdateDispatcher) 
		{
			this.container = new Sprite();
			
			this.container.x = 5;
			this.container.y = Constants.HEIGHT - 60;
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener("restore");
			flow.addUpdateListener("protagonistDamaged");
			
			flow.dispatchUpdate("addToTheHUD", this.container);
		}
		
		public function restore():void
		{
			this.healthPoints = int(getActorsXML().actor[0].baseHP);
			
			this.container.removeChildren();
			
			this.points = new Vector.<Quad>();
			
			for (var i:int = 0; i < this.healthPoints; i++)
			{
				var point:Quad = new Quad(10, 10, 0x000000);
				
				point.x = 12 * (i / this.POINTS_PER_COLUMN);
				point.y = 12 * (i % this.POINTS_PER_COLUMN);
				
				this.container.addChild(point);
				this.points.push(point);
			}
		}
		
		public function protagonistDamaged(damage:int):void
		{
			while (damage > 0 && this.points.length > 0)
			{
				var point:Quad = this.points.pop();
				this.container.removeChild(point);
				
				damage--;
			}
		}
		
	}

}