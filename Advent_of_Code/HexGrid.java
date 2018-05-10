import java.util.Scanner;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Array;

public class HexGrid {
	public static void main(String[] args) {
		int x = 0;
		int y = 0;
		int z = 0;
		int HighDist = 0;
		
		Point pt = new Point();
		
		ReadFile file = new ReadFile("src/data/input.txt" );
		String[] directions = file.Read();
		
		for (int i = 0; i < directions.length; i++) {
		    switch(directions[i]) {
		    case "n":   ++y; --z; break;
		    case "ne":  ++x; --z; break;
		    case "se":  ++x; --y; break;
		    case "s":   --y; ++z; break;
		    case "sw":  --x; ++z; break;
		    case "nw":  ++y; --x; break;
		    default: break;
		    }
		    
			if ( HighDist < pt.distance(x, y, z)){
				HighDist = pt.distance(x, y, z);
		    }
		    
		}
		Point p = new Point( x,y,z);
		System.out.println ( p.distance());
		System.out.println(HighDist);
	}
}

class ReadFile {

	private String fileName;
	private Array[] File ;
	private Scanner s; 
	
	public ReadFile ( String Filename){
		this.fileName = Filename;
		try {
			this.s = new Scanner(new File(fileName));
		} catch (IOException e) {
			System.out.println(e);
		}

	}

	public String[] Read() {
		String[]  input = null;
		while (s.hasNext() ) {
			input = s.next().split(",");
//			System.out.println(s.next());
		}
		return input;
	}
	
}


class Point {

	private int x = 0;
	private int y = 0;
	private int z = 0;
	
	public Point(int x, int y, int z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}
	
	public Point() {
	}

    public int distance(int xx, int yy, int zz) {
        return (Math.abs(Math.abs(xx) - this.x) + Math.abs(Math.abs(yy) - this.y) + Math.abs(Math.abs(zz) - this.z)) / 2;
    }

	public int distance() {
        return (Math.abs(Math.abs(x) - this.x) + Math.abs(Math.abs(y) - this.y) + Math.abs(Math.abs(z) - this.z)) / 2;
    }
    

}
