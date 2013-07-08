package chaotic.scene.patterns 
{
	
	internal class CirclePattern extends MiddlePattern 
	{
		private var radius:int, xPeriod:int, yPeriod:int;
		
		public function CirclePattern(item:Pattern) 
		{
			super(item);
			
			this.xPeriod = 10 + Math.random() * 20;
			this.yPeriod = 10 + Math.random() * 20;
			
			this.radius = Math.min(this.xPeriod, this.yPeriod) / 2;
			this.radius *= this.radius;
		}
		
		override protected function getLocalNumber(x:int, y:int):int
		{
			var cX:int = x - int(x / this.xPeriod) * this.xPeriod; 
			var cY:int = y - int(y / this.yPeriod) * this.yPeriod;
			
			cX *= cX; cY *= cY;
			
			return (cX + cY <= this.radius) ? 1 : 0;
		}
	}

}