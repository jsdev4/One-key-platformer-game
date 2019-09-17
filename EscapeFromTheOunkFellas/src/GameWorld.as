package
{
	import com.adobe.tvsdk.mediacore.TextFormat;
	import flash.media.SoundLoaderContext;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.ui.Mouse;
	import flash.text.Font;
	public class GameWorld extends World
	{
		[Embed(source="04 - Catch Him!.mp3")]
		private const MUSIC:Class;
		private var music:Sfx;
		[Embed(source="08 - Stage Clear.mp3")]
		private const SUCCESS:Class;
		private var success:Sfx;
		protected var titleText:Text;
		protected var pressText:Text;
		protected var winText:Text;
		private var titleTweenIn:VarTween;
		private var titleTweenOut:VarTween;
		private var pressTweenIn:VarTween;
		private var pressTweenOut:VarTween;
		private var winTextTween:VarTween;
		private var winTextTweenOut:VarTween;
		public var status:String;
		private var back_:Background;
		private var player:Player;
		private var level_0:Level0;
		private var level_01:Level01;
		private var level_02:Level02;
		private var game_finished:Boolean;
		private var obstacle01:Obstacle0;
		private var obstacle02:Obstacle0;
		private var obstacle03:Obstacle0;
		private var obstacle04:Obstacle0;
		private var obstacle05:Obstacle0;
		private var obstacle06:Obstacle0;
		private var obstacle07:Obstacle0;
		private var punk_0:Punks;
		private var punk_01:Punks;
		private var punk_011:Punks;
		private var punk_02:Punks;
		private var front_end:FrontEnd;
		public function GameWorld()
		{
			
			success = new Sfx(SUCCESS);
			music = new Sfx(MUSIC);
			game_finished = false;
			this.titleText = new Text("ESCAPE FROM THE PUNK FELLAS!");
			this.pressText = new Text("Press SPACE to start, \nSPACE to jump \nSPACE for everything!");
			this.winText = new Text("You has escaped!Press Space");
			this.titleText.color = 0xFFFFFF;
			this.titleText.scale = 2;
			this.titleText.alpha = 0;
			this.pressText.color = 0xFFFFFF;
			this.pressText.alpha = 0;
			this.pressText.scale = 1;				
			this.winText.color = 0xFFFFFF;
			this.winText.scale = 2;
			this.winText.alpha = 0;
			this.titleText.x = ((FP.screen.width/2)-250);
			this.pressText.x = ((FP.screen.width/2)-100);
			this.titleText.y = ((FP.screen.height/2)-100);
			this.pressText.y = ((FP.screen.height/2)-50);
			this.winText.x = ((FP.screen.width / 2) - 250);
			this.winText.y=(FP.screen.y+20);
			titleTweenIn = new VarTween();
			titleTweenOut = new VarTween();
			pressTweenIn = new VarTween();
			pressTweenOut = new VarTween();
			winTextTween = new VarTween();
			winTextTweenOut = new VarTween();
			this.status = "START";
			back_ = new Background(0, 0);
			player = new Player(FP.screen.x + 30, FP.screen.height -20);
			level_0 = new Level0(FP.screen.x, FP.screen.height - 12);
			level_01 = new Level01(FP.screen.x, FP.screen.height - 172);
			level_02 = new Level02(FP.screen.x, FP.screen.height - 344);
			obstacle01 = new Obstacle0(382, FP.screen.height - 44);
			obstacle04 = new Obstacle0(380, FP.screen.height -204);
			obstacle05 = new Obstacle0(150, FP.screen.height - 376);
			obstacle06 = new Obstacle0(340, FP.screen.height - 376);
			obstacle07 = new Obstacle0(510, FP.screen.height -376);
			punk_0 = new Punks(FP.screen.width + 80, FP.screen.height - 80);
			punk_01 = new Punks(FP.screen.x - 20, FP.screen.height - 240);
			punk_011=new Punks (FP.screen.x - 60, FP.screen.height - 240);
			punk_02 = new Punks(FP.screen.width , FP.screen.height - 414);
			front_end = new FrontEnd(0, 0);
			this.add(back_);
			this.add(level_0);
			this.add(level_01);
			this.add(level_02);
			this.add(obstacle01);
			this.add(obstacle04);
			this.add(obstacle05);
			this.add(obstacle06);
			this.add(obstacle07);
			this.add(player);
			this.add(front_end);
			this.player.visible = false;
			this.addGraphic(titleText);
			this.addGraphic(pressText);
			this.addTween(titleTweenIn);
			this.addTween(pressTweenIn);
			this.addTween(titleTweenOut);
			this.addTween(pressTweenOut);
			this.addGraphic(winText);
			this.addTween(winTextTween);
			this.addTween(winTextTweenOut);
		}
		public override function update():void
		{
			switch(status)
			{
				case "START":
				{	
					titleTweenIn.tween(titleText, "alpha", 1, 3);	
					pressTweenIn.tween(pressText, "alpha", 1, 3);
					this.status = "WAIT1";
					break;
				}
				case "TO": 
				{
					if (Input.check(Key.SPACE))
					{
						
						music.play(0.2,0);
						titleTweenOut.tween(titleText, "alpha", 0, 3);
						pressTweenOut.tween(pressText,  "alpha", 0, 3);
						this.status = "WAIT2";	
					}
					break;
				}
				case "GAME":
				{
					this.player.visible = true;	
					FP.world.bringToFront(front_end);
					if (player.getFloor() == 0)
					{
						player.y = FP.screen.height -20;
						this.add(punk_0);
						punk_0.get_the_flip();	
					}
					if (player.getFloor() == 1)
					{
						player.y = FP.screen.height -180;
						this.add(punk_01);
						this.add(punk_011);		
					}
					if (player.getFloor() == 2)
					{
						player.y = FP.screen.height -352;
						this.add(punk_02);
						punk_02.get_the_flip();
					}
					if (player.getFloor() ==2  && player.getX() >= FP.screen.width - 40)
					{
						music.stop();
						success.play(0.2,0);
						player.is_running = false;
						player.animation_status();
						this.status = "WIN";
						game_finished = true;							
					}
					if (player.get_gameOver() == true)
					{
						music.stop();
					}
				}
				case "SHOWMESSAGE":
				{
					if (game_finished == true)
					{
						winTextTween.tween(winText,  "alpha", 1, 3);
						if (Input.check(Key.SPACE))
						{	
							FP.world = new GameWorld();
						}
					}
					break;
				}
			}
			if (titleTweenIn.percent == 1 && pressTweenIn.percent == 1 && this.status == "WAIT1")
			{
				this.status = "TO";
			}
			if (titleTweenOut.percent == 1 && pressTweenOut.percent == 1 && this.status == "WAIT2")
			{
				this.status = "GAME";
			}
			if (winTextTween.percent == 0 && this.status == "WIN")
			{
				this.status = "SHOWMESSAGE";
			}
			super.update();
		}	
	}
}