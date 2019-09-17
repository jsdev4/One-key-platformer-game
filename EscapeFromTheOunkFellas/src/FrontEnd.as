package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	/**
	 * ...
	 * @author Juan
	 */
	public class FrontEnd extends Entity
	{
		
		[Embed(source="front_end.png")]
		private const FRONT:Class;
		private var front:Image;
		public function  FrontEnd(px:Number = 0, py:Number = 0) 
		{
			front = new Image(FRONT);
			super(px, py,front);
		}
		override public function update():void
		{
			
			super.update();
		}	

	}
}