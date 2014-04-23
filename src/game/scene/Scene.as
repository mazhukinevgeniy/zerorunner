package game.scene 
{
	import data.viewers.GameConfig;
	import flash.utils.ByteArray;
	import utils.MapXML;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Scene implements IScene
	{
		private var scene:ByteArray;
		
		public function Scene(flow:IUpdateDispatcher) 
		{
			this.scene = new ByteArray();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.restore);
		}
		
		update function restore(config:GameConfig):void
		{
			this.scene.clear();
			this.scene.length = Game.MAP_WIDTH * Game.MAP_WIDTH;
			
			var map:XML = MapXML.getOne();
			
			if (map.@width != map.@height || map.@width != Game.MAP_WIDTH)
				throw new Error("map is not compatible");
			
			var tileCodes:Array = new Array();
			
			for (var i:int = 0; i < map.tileset.length(); i++)
			{
				var name:String = map.tileset[i].@name;
				
				if (name == "fall")
					tileCodes[i + 1] = Game.SCENE_FALL;
				else if (name == "ground")
					tileCodes[i + 1] = Game.SCENE_GROUND;
				else if (name == "bot_left")
					tileCodes[i + 1] = Game.SCENE_BL_DISK;
				else if (name == "bot_right")
					tileCodes[i + 1] = Game.SCENE_BR_DISK;
				else if (name == "top_left")
					tileCodes[i + 1] = Game.SCENE_TL_DISK;
				else if (name == "top_right")
					tileCodes[i + 1] = Game.SCENE_TR_DISK;
			}
			
			const LENGTH:int = this.scene.length;
			var tiles:XMLList = map.layer.data.tile;
			
			for (var j:int = 0; j < LENGTH; j++)
			{
				this.scene[j] = tileCodes[tiles[j].@gid];
			}
			
			this.validateTheMap();
			
			//TODO: check if we ever need to rerestore the map
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.scene[x + y * Game.MAP_WIDTH];
		}
		
		private function validateTheMap():void
		{
			
			//TODO: add map validation
			//TODO: remove as soon as the game is done
		}
	}

}