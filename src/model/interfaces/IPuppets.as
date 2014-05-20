package model.interfaces 
{
	import model.items.ItemSnapshot;
	
	public interface IPuppets 
	{
		function getItemSnapshot(cellId:int):ItemSnapshot;
	}
	//TODO: rename
}