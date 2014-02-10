package game.hud 
{
	import game.fuel.IFuel;
	import game.GameElements;
	import starling.display.Quad;
	import starling.display.Sprite;
	import utils.updates.update;
	
	internal class FuelView 
	{
		private var fuel:IFuel;
		
		
		private var body:Sprite;
		
		private var indicator:Quad;
		
		public function FuelView(elements:GameElements) 
		{
			this.fuel = elements.fuel;
			
			this.body = new Sprite();
			this.drawBody(this.body, this.fuel.getFuelCap());
			
			elements.displayRoot.addChild(this.body);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.numberedFrame);
		}
		
		private function drawBody(root:Sprite, cap:int):void
		{
			const width:int = cap + 4;
			const height:int = 20;
			
			var back:Quad = new Quad(width, height, 0xAA6666);
			this.body.addChild(back);
			
			this.indicator = new Quad(1, height - 4, 0xFF7777);
			this.indicator.x = 2;
			this.indicator.y = 2;
			this.body.addChild(this.indicator);
			
			this.body.x = 2;
			this.body.y = Main.HEIGHT - (2 + height);
		}
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_ACT + 1)
			{
				this.indicator.scaleX = this.fuel.getAmountOfFuel();
				
				this.body.flatten();
			}
		}
	}

}