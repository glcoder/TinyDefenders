package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	import Entities.*;
	
	/**
	 * Main game state
	 * 
	 * @author Artem Gurevich / RadicalEd
	 */
	public class GameState extends FlxState {
		private var m_player:Player;
		
		private var m_projectiles:FlxGroup;
		private var m_enemies:FlxGroup;
		private var m_defenders:FlxGroup;
		private var m_effects:FlxGroup;
		private var m_ui:FlxGroup;
		
		private var m_nextWaveButton:FlxButton;
		private var m_scoreText:FlxText;
		
		private var m_wave:Wave;
		private var m_waveCount:Number;
		private var m_currentWave:Number;
		
		override public function create():void  {
			add(FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0xFF8BADF7, 0xFFE1E8F7, 0xFFFFFFFF], 2));
			
			m_projectiles = new FlxGroup();
			m_enemies     = new FlxGroup();
			m_defenders   = new FlxGroup();
			m_effects     = new FlxGroup();
			m_ui          = new FlxGroup();
			m_player      = new Player(150, FlxG.height * 0.5);
			
			createCloudEmitter();
			add(m_projectiles);
			add(m_enemies);
			add(m_defenders);
			add(m_player);
			add(m_effects);
			add(m_ui);
			
			FlxG.score = 5;
			
			m_scoreText = new FlxText(10, FlxG.height - 84, 200, "");
			m_scoreText.color = 0xFF000000;
			m_scoreText.size  = 16;
			
			m_nextWaveButton = new FlxButton(100, 10, "Next Wave", spawnNextWave);
			
			m_ui.add(m_nextWaveButton);
			m_ui.add(new FlxButton(10, 10, "Restart", resetGame));
			m_ui.add(new FlxBar(10, FlxG.height - 20, FlxBar.FILL_LEFT_TO_RIGHT, 200, 10, m_player, "health"));
			m_ui.add(m_scoreText);
			
			m_currentWave = 1;
			m_waveCount   = FlxG.score;
			
			m_wave = new Wave(m_waveCount);
		}
		
		public function get player():Player        { return m_player;      }
		public function get projectiles():FlxGroup { return m_projectiles; }
		public function get enemies():FlxGroup     { return m_enemies;     }
		public function get defenders():FlxGroup   { return m_defenders;   }
		public function get effects():FlxGroup     { return m_effects;     }
		public function get ui():FlxGroup          { return m_ui;          }
		
		private function spawnNextWave():void {
			m_waveCount *= 1.7;
			FlxG.score  += m_defenders.countLiving();
			++m_currentWave;
			
			m_enemies.clear();
			m_defenders.clear();
			m_projectiles.clear();
			m_effects.clear();
			
			m_wave = new Wave(m_waveCount);
		}
		
		private function resetGame():void {
			FlxG.resetGame();
		}
		
		private function createCloudEmitter():void {
			var cloudEmitter:FlxEmitter = new FlxEmitter(FlxG.width + 64, 40);
			
			cloudEmitter.particleClass = Cloud;
			cloudEmitter.setXSpeed( -120, -40);
			cloudEmitter.setYSpeed();
			cloudEmitter.setRotation();
			cloudEmitter.setSize(0, FlxG.height - 80);
			
			add(cloudEmitter);
			
			cloudEmitter.start(false, 0, 0.5, 0);
		}
		
		override public function update():void  {
			m_scoreText.text =
				"Wave         : " + m_currentWave + "\n" +
				"Enemies    : " + m_wave.count + "\n" +
				"Defenders : " + FlxG.score + "\n";
			m_nextWaveButton.visible = m_wave.isComplete();
			
			super.update();
		}
	}
}
