package game.ui 
{
	import game.actors.ActorsFeature;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import game.ZeroRunner;
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
			this.container.y = Main.HEIGHT - 60;
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.heroDamaged);
			flow.addUpdateListener(ActorsFeature.setHeroHP);
			
			flow.dispatchUpdate(ZeroRunner.addToTheHUD, this.container);
		}
		
		public function setHeroHP(hp:int):void
		{
			this.healthPoints = hp;
			
			this.container.removeChildren();
			
			this.points = new Vector.<Quad>();
			
			for (var i:int = 0; i < this.healthPoints; i++)
			{
				var point:Quad = new Quad(10, 10, 0xAAAAAA);
				
				point.x = 12 * (i / this.POINTS_PER_COLUMN);
				point.y = 12 * (i % this.POINTS_PER_COLUMN);
				
				this.container.addChild(point);
				this.points.push(point);
			}
		}
		
		public function heroDamaged(damage:int):void
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