import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import java.util.Scanner;


public class BuildTower {
	
	private NodeFactory nf = new NodeFactory();

	public static void main(String[] args) {
		ReadFile file = new ReadFile("input.fl" );
		while ( file.HasNext() ){
			String nodeInfo = file.Read();
		}
		
	}

}

class Node{
	private int selfWeight;
	private String name;
	private List<Node> childs = new ArrayList<Node>();
	
	public Node(String name , int weight){
		this.name = name;
		this.selfWeight = weight;
	}
	
	public int getSelfWeight() {
		return selfWeight;
	}
	public void setSelfWeight(int selfWeight) {
		this.selfWeight = selfWeight;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<Node> getChilds() {
		return childs;
	}
	public void setChilds(List<Node> childs) {
		this.childs = childs;
	}
	
	public void addChild ( Node child ){
		this.childs.add(child);
	}
	
	public Node getChildNodebyName(Node node, String nodeName){
		for (Node child : node.childs) {
			if ( child.getName().equals(nodeName)){
				return child;
			}else{
				getChildNodebyName( child , nodeName);
			}
				
		}
		return null;
	}
	
}

class NodeFactory{
	public NodeFactory(){
		
	}
	private static Dictionary<String, Node> nodePool = new Hashtable<String, Node>();

	public Node newNode( String name , int weight){
		Node node = nodePool.get(name);
		if ( node == null){
			nodePool.put(name , new Node(name, weight));
			return nodePool.get(name);
		}else{
			return node;
		}
		
	}
}

class ReadFile {

	private String fileName;
	private Scanner s; 
	
	public ReadFile ( String Filename){
		this.fileName = Filename;
		try {
			this.s = new Scanner(new File(fileName));
		} catch (IOException e) {
			System.out.println(e);
		}

	}
	
	public boolean HasNext(){
		return s.hasNextLine();
	}

	public String Read() {
		String  input = null;
		if (s.hasNextLine() ) {
			input = s.nextLine();
			
			if ( input.replaceAll("^(.*) \\((\\d+)\\)$" , "$1-$2") != null ){
				System.out.println("$1$2");
			}else if ( input.matches("^(.*) \\((\\d+)\\) \\-\\> (.*)$") ){
				System.out.println("$1$2$3");
			}
			
			return input;
		}else{
			return null;
		}
		
	}
	
}
