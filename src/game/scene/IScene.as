package game.scene 
{
	import game.metric.CellXY;
	
	public interface IScene
	{
		function getSceneCell(cell:CellXY):int;
	}
	
}