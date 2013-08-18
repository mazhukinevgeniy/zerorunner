package game.ui 
{
	import game.epicenter.items.ActorsFeature;
	import starling.display.Quad;
	import starling.display.Sprite;
	import utils.templates.UpdateGameBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
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
			
			flow.dispatchUpdate(UpdateGameBase.addToTheHUD, this.container);
		}
		
		update function setHeroHP(hp:int):void
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
		
		update function heroDamaged(damage:int):void
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