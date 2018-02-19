package Entities 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	import Entities.Defenders.*;
	
	/**
	 * Main player
	 * 
	 * @author Artem Gurevich / RadicalEd
	 */
	public class Player extends FlxButton {
		private var m_destinationY:Number;
		private var m_originalY:Number;
		
		private var m_buildText:FlxText;
		private var m_buildBar:FlxBar;
		private var m_buildTimer:FlxTimer;
		
		private var m_shootTimer:FlxTimer;
		
		private var m_buildProgress:Number;
		
		public function Player(X:Number, Y:Number)  {
			super(X, Y, null, buildDefender);
			loadGraphic(Assets.PLAYER, false, false, 64, 64);
			
			m_originalY    = Y;
			m_destinationY = m_originalY + FlxMath.rand( -15, 15);
			
			m_buildText = new FlxText(x, y - 16, 100, "Click to build");
			m_buildText.color = 0xFF000000;
			
			m_buildBar = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 64, 2, this, "buildProgress", 0, 1);
			m_buildBar.trackParent(0, -8);
			
			m_buildTimer = new FlxTimer();
			m_buildTimer.finished = true;
			
			m_buildProgress = 0;
			health = 100;
			
			if (FlxG.state is GameState) {
				var gameState:GameState = FlxG.state as GameState;
				gameState.ui.add(m_buildText);
			}
			
			m_shootTimer = new FlxTimer();
			m_shootTimer.start(1, 0, shoot);
		}
		
		public function get buildProgress():Number { return m_buildProgress; }
		
		private function shoot(timer:FlxTimer):void {
			if (!alive)
				timer.stop();
			
			if (FlxG.state is GameState) {
				var gameState:GameState = FlxG.state as GameState;
				var enemy:FlxSprite = Util.getRandomEntity(gameState.enemies);
				if (enemy != null) {
					var position:FlxPoint = getMidpoint();
					gameState.projectiles.add(new Projectile(position.x, position.y, enemy));
				}
			}
		}
		
		override public function update():void  {
			m_buildProgress = m_buildTimer.progress;
			
			if (health <= 0)
				kill();
			
			if (FlxU.abs(y - m_destinationY) > 1) {
				y += FlxU.sign(m_destinationY - y) * 6 * FlxG.elapsed;
			} else {
				m_destinationY = m_originalY + FlxMath.rand( -15, 15);
			}
			
			super.update();
		}
		
		private function buildDefender():void {
			if (!alive || FlxG.score < 1 || !m_buildTimer.finished)
				return;
			
			m_buildText.visible = false;
			
			if (FlxG.state is GameState) {
				var gameState:GameState = FlxG.state as GameState;
				gameState.ui.add(m_buildBar);
			}
			
			m_buildProgress = 0;
			
			FlxG.play(Assets.SFX_CLICK, 0.6);
			m_buildTimer.start(0.5, 1, buildComplete);
		}
		
		
		private function buildComplete(timer:FlxTimer):void {
			if (FlxG.state is GameState) {
				var gameState:GameState = FlxG.state as GameState;
				gameState.ui.remove(m_buildBar);
				
				var position:FlxPoint = getMidpoint();
				gameState.defenders.add(new TinyDefender(position.x, position.y));
				
				--FlxG.score;
			}
		}
	}
}
