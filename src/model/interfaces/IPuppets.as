package model.interfaces 
{
	import model.items.PuppetBase;
	
	public interface IPuppets 
	{
		function findObjectByCell(cellId:int):PuppetBase;
	}
	
}