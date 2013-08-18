package game.scene 
{
	import game.epicenter.SearcherFeature;
	import game.scene.patterns.FlatPattern;
	import game.scene.patterns.getPattern;
	import game.scene.patterns.IPattern;
	import game.utils.metric.ICoordinated;
	import utils.templates.UpdateGameBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Scene
	{		
		private var patterns:Vector.<IPattern>;
		
		public function Scene(flow:IUpdateDispatcher)
		{
			this.patterns = new Vector.<IPattern>(SceneFeature.NUMBER_OF_PATTERNS, true);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(SearcherFeature.cacheScene);
			flow.addUpdateListener(UpdateGameBase.prerestore);
		}
		
		update function cacheScene(cache:Vector.<int>, center:ICoordinated, width:int, height:int):void
		{			
			var tlcX:int = center.x - width / 2;
			var tlcY:int = center.y - height / 2;
			
			for (var i:int = 0, x:int = tlcX; i < width; i++, x++)
				for (var j:int = 0, y:int = tlcY; j < height; j++, y++)
				{
					cache[i + j * width] =
						this.patterns[uint((x * 84673) ^ (y * 108301)) % SceneFeature.NUMBER_OF_PATTERNS].getNumber(x, y);
				}
		}
		
		update function prerestore():void
		{
			var specN1:int = Math.random() * SceneFeature.NUMBER_OF_PATTERNS;
			var specN2:int = specN1;
			while (specN1 == specN2)
				specN2 = Math.random() * SceneFeature.NUMBER_OF_PATTERNS;
			
			for (var i:int = 0; i < SceneFeature.NUMBER_OF_PATTERNS; i++)
			{
				if (i == specN1 || i == specN2)
					this.patterns[i] = new FlatPattern();
				else
					this.patterns[i] = getPattern();
			}
		}
	}

}