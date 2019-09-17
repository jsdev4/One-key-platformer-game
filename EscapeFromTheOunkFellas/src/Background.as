package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Juan
	 */
	public class Background extends Entity
	{
		[Embed(source = "background.png")]
		private const BACKGROUND:Class;
		private var background:Image;
		public function Background(px:Number = 0, py:Number = 0) 
		{
			background = new Image(BACKGROUND);
			super(px, py,background);
		}
		override public function update():void
		{
			super.update();
		}	
	}
}