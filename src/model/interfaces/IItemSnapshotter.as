package model.interfaces 
{
	import model.items.ItemSnapshot;
	
	public interface IItemSnapshotter 
	{
		function getItemSnapshot(cellId:int):ItemSnapshot;
	}
}