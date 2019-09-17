package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Juan
	 */
	public class Level01 extends Entity
	{
		[Embed(source = "level01.png")] private const LEVEL01:Class;
		private var level01:Image;
		public function Level01(px:Number = 0,py:Number=0) 
		{
			level01 = new Image( LEVEL01);
			super(px, py,level01);
			mask = new Pixelmask( LEVEL01);
			type = "Level01";
		}
		override public function update():void
		{
			var collidable:Entity = this.collide("Player", this.x, this.y);
			if (collidable)
			{
				var tempPlayer:Player = collidable as Player;
				tempPlayer.y = this.y -66;
			}
			super.update();
		}
	}
}