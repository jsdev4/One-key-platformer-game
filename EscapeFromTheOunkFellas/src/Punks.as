package 
{
	import flash.events.AsyncErrorEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Juan
	 */
	public class Punks extends Entity
	{
		[Embed(source = "punk_standby.png")]
		private const PUNKS:Class;
		private var punks:Image;
		[Embed(source = "punks_fixed.png")]
		private const PUNK_ANIM:Class;
		private var punk_anim:Spritemap;
		public var is_flipped:Boolean;
		public function Punks(px:Number = 0, py:Number = 0)
		{
			is_flipped = false;
			punks = new Image(PUNKS);
			punk_anim = new Spritemap(PUNK_ANIM,58,70);
			punk_anim.add("running", [ 1 , 2, 3], 10, true);
			super(px, py, punk_anim);
			mask = new Pixelmask(PUNKS);
			type = "Punks";
		}
		override public function update():void
		{
			punk_anim.play("running");
			if (is_flipped == true)
			{
				punk_anim.flipped = true;
				x -= 100 * FP.elapsed;
			}
			if (is_flipped == false)
			{
				punk_anim.flipped = false;
				x += 100 * FP.elapsed;
			}
			var collidable:Entity = this.collide("Player", this.x, this.y);
			if (collidable)
			{
				var tempPlayer:Player = collidable as Player;
				tempPlayer.die();	
			}
			super.update();
		}
		public function get_the_flip():void
		{
			is_flipped = true;
		}
	}
}