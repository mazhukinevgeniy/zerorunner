package model 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import flash.utils.ByteArray;
	import model.interfaces.IScene;
	import model.utils.normalize;
	
	public class Scene implements IScene
	{
		private var scene:ByteArray;
		
		public function Scene(binder:IBinder) 
		{
			this.scene = new ByteArray();
			
			this.scene.length = Game.MAP_WIDTH * Game.MAP_WIDTH;
			
			var map:XML = MapXML.getOne();
			
			if (map.@width != map.@height || map.@width != Game.MAP_WIDTH)
				throw new Error("map is not compatible");
			
 			var tileCodes:Array = this.getTileCodes(map);
			
			const LENGTH:int = this.scene.length;
			var tiles:XMLList = map.layer.data.tile;
			
			for (var j:int = 0; j < LENGTH; j++)
			{
				this.scene[j] = tileCodes[tiles[j].@gid];
			}
			
		}
		
		private function getTileCodes(map:XML):Array
		{
			var tileCodes:Array = new Array();
			
			var discNames:Array = ["bot_left", "bot_right", "top_left", "top_right"];
			
			for (var i:int = 0; i < map.tileset.length(); i++)
			{
				var name:String = map.tileset[i].@name;
				
				if (name == "fall")
					tileCodes[i + 1] = Game.SCENE_FALL;
				else if (name == "ground")
					tileCodes[i + 1] = Game.SCENE_GROUND;
				else if (discNames.indexOf(name) != -1)
					tileCodes[i + 1] = Game.SCENE_DISK;
			}
			
			return tileCodes;
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.scene[x + y * Game.MAP_WIDTH];
		}
	}

}