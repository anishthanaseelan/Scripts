import java.io.File;
import java.io.IOException;
import java.util.Dictionary;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Scanner;

public class Firewall {

	private static BotFactory bf = new BotFactory();

	public static void main(String[] args) {
		ScannerBot bot = null;
		Integer scv = 1;
		createBots();
		
		// Move Bots
		Integer skiptime = 10;
		while (scv != 0) {
			bf.resetBots();
			scv = 0;
			
			for ( int time = 0; time < skiptime; time++){
				bf.moveBots();
			}
			
			scv = movePackage();
			
			if ( skiptime > 100000){
 				break;
 			}
 			System.out.println("Skip Level is " + skiptime + " The Sceviarity is " + scv );
 			skiptime++;
		}
		
	}
	
	private static void createBots(){
		ReadFile file = new ReadFile(
				"C:\\Users\\athanas\\workspace\\DodgingFirewall\\src\\input.fl");
		while (file.HasNext()) {
			String scannerinfo = file.Read();
			Integer.parseInt(scannerinfo.split(":")[0].trim());
			bf.newBot(Integer.parseInt(scannerinfo.split(":")[0].trim()),
					Integer.parseInt(scannerinfo.split(":")[1].trim()));
		}

	}
	private static Integer movePackage(){
		ScannerBot bot = null;
		Integer scv = 0;
			for (int level = 0; level < 101 ; level++) {
			//System.out.println("Second " + level);
			bot = bf.getBot(level);

			if (bot != null) {

				if (bot.getCurrentPosition() == 0) {
		//			System.out.println(" The Bot " + bot.getLevel()
			//				+ " is at " + bot.getCurrentPosition());
					scv += (bot.getLevel() * bot.getRange());
				}
			}
			bf.moveBots();
		}
			return scv;
	}
}

class ScannerBot {

	private Integer level = null;
	private Integer range = null;
	private Integer currentPosition = 0;
	private boolean goingUp = false;

	public void setGoingUp(boolean goingUp) {
		this.goingUp = goingUp;
	}

	public ScannerBot(Integer level, Integer range) {
		this.level = level;
		this.range = range;
		this.currentPosition = 0;
		System.out.println("Bot at Level " + this.level + " Range" + this.range
				+ " has been created");

	}

	public void setCurrentPosition(Integer currentPosition) {
		this.currentPosition = currentPosition;
	}

	public Integer getLevel() {
		return level;
	}

	public Integer getRange() {
		return range;
	}


	public Integer getCurrentPosition() {
		return currentPosition;
	}

	public void move() {

		if (goingUp) {
			this.currentPosition--;
		} else {
			this.currentPosition++;
		}
		if ((this.currentPosition) == (this.range - 1)) {
			this.goingUp = true;
		} else if ((this.currentPosition) == 0) {
			this.goingUp = false;
		}
	}
}

class BotFactory {
	private static Dictionary<Integer, ScannerBot> botPool = new Hashtable<Integer, ScannerBot>();

	public BotFactory() {

	}

	public void resetBots() {
		Enumeration<ScannerBot> bots = botPool.elements();
		ScannerBot bot = null;
		while (bots.hasMoreElements()) {
			bot = bots.nextElement();
			bot.setCurrentPosition(0);
			bot.setGoingUp(false);
			
		}
		
		
	}

	public ScannerBot newBot(Integer level, Integer range) {
		ScannerBot bot = botPool.get(level);
		if (bot == null) {
			botPool.put(level, new ScannerBot(level, range));
			bot = botPool.get(level);
		}
		return bot;
	}

	public ScannerBot getBot(Integer level) {
		return (botPool.get(level));
	}

	public void moveBots() {

		Enumeration<ScannerBot> bots = botPool.elements();
		ScannerBot bot = null;
		while (bots.hasMoreElements()) {
			bot = bots.nextElement();
			bot.move();
	//		System.out.println(" Bot " + bot.getLevel() + " Moved to "
		//			+ bot.getCurrentPosition());
		}
	}
}

class ReadFile {

	private String fileName;
	private Scanner s;

	public ReadFile(String Filename) {
		this.fileName = Filename;
		try {
			this.s = new Scanner(new File(fileName));
		} catch (IOException e) {
			System.out.println(e);
		}

	}

	public boolean HasNext() {
		return s.hasNextLine();
	}

	public String Read() {
		String input = null;
		if (s.hasNextLine()) {
			input = s.nextLine();

			return input;
		} else {
			return null;
		}

	}

}