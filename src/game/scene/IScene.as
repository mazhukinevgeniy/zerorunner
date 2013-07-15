package game.scene 
{
	import game.metric.CellXY;
	
	public interface IScene
	{
		function getSceneCell(x:int, y:int):int;
	}
	
}