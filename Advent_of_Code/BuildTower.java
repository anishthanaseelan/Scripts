import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;
import java.util.Scanner;

public class BuildTower {

	private static NodeFactory nf = new NodeFactory();

	public static void main(String[] args) {
		Node parentNode = null;

		ReadFile file = new ReadFile(
				"node.txt");
		while (file.HasNext()) {
			String nodeInfo = file.Read();
			String[] info = null;
			Node node = null;
			if (nodeInfo.matches("^(.*) \\((\\d+)\\)$")) {
				info = nodeInfo.replaceAll("^(.*) \\((\\d+)\\)$", "$1-$2").split("-");
				nf.newNode(info[0], Integer.parseInt(info[1].trim()));
			} else if (nodeInfo.matches("^(.*) \\((\\d+)\\) \\-\\> (.*)$")) {
				info = nodeInfo.replaceAll("^(.*) \\((\\d+)\\) \\-\\> (.*)$", "$1-$2-$3").split("-");
				node = nf.newNode(info[0], Integer.parseInt(info[1].trim()));
				for (String childName : info[2].split(",")) {
					node.addChild(nf.newNode(childName.trim()));
				}

			}
		}
		
		parentNode = nf.findParent();
		
		if ( parentNode != null) {
			System.out.println(" The Parent is " + parentNode.getName());
		}else {
			System.out.println("No Parent found");
			return;
		}
		
		parentNode.calculateChildWeight();
		parentNode.findImbalance();
		parentNode.printChild();
		nf.newNode("bntzksk").printChild();
		nf.newNode("vmttcwe").printChild();
		nf.newNode("qlchz").printChild();
		nf.newNode("mvpqv").printChild();
	}

}

class Node {
	private Integer selfWeight = null;
	private String name = null;
	private List<Node> childs = new ArrayList<Node>();
	private Integer childWeight = null;

	public Integer getChildWeight() {
		return childWeight;
	}
	public void printChild() {
		System.out.print ( "Childs of " + this.getName() + " [" + this.getSelfWeight()+ "] is ");
		for (Node node : this.getChilds()) {
			System.out.print ( node.getName() + " [" + node.getSelfWeight()+ "]" + " (" + node.getChildWeight() + ") ");
		}
		System.out.println();
		
	}

	public void findImbalance() {
		if ( this.getChilds().isEmpty() ) {
			return;
		}
		Integer prevWeight = null;
		for (Node node : this.getChilds()) {
			if ( prevWeight == null) {
				prevWeight = node.getChildWeight();				
			}

			if ( node.getChildWeight() != prevWeight ) {
				node.findImbalance();
				System.out.println("Node " + this.getName() + " is Imbalanced " );
				break;
			}
			prevWeight = node.getChildWeight();	
			
			
		}
		
		
	}

	public void setChildWeight(Integer childWeight) {
		this.childWeight = childWeight;
	}

	public Node(String name, Integer weight) {
		this.name = name;
		this.selfWeight = weight;
		this.setChildWeight(0);
		//System.out.println("Node <" + this.name + "> created");
	}

	public void calculateChildWeight() {
		if ( this.getChilds().isEmpty() ) {
			this.setChildWeight(this.getSelfWeight());	
			System.out.println ( "The Leaf Child Weight of " + this.getName() + " is " + this.getChildWeight() );
			return;
		}

		for (Node node : this.getChilds()) {
			node.calculateChildWeight();
			this.setChildWeight( node.getChildWeight() + this.getChildWeight() );
		}
		//TODO Comment below to pay around
		this.setChildWeight ( this.getChildWeight() + this.getSelfWeight());
		System.out.println ( "The Child Weight of " + this.getName() + " is " + this.getChildWeight() );
	}

	public Node(String name) {
		this.setName( name );
		this.setChildWeight(0);
		//System.out.println("Child Node <" + this.name + "> created");
	}

	public Integer getSelfWeight() {
		return selfWeight;
	}

	public void setSelfWeight(Integer selfWeight) {
		this.selfWeight = selfWeight;
		//System.out.println("Child Node <" + this.name + "> updated");
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

	public void addChild(Node child) {
		this.childs.add(child);
	}

	public Node getChildNodebyName(Node node, String nodeName) {
		for (Node child : node.childs) {
			if (child.getName().equals(nodeName)) {
				return child;
			} else {
				getChildNodebyName(child, nodeName);
			}

		}
		return null;
	}

}

class NodeFactory {

	private static Dictionary<String, Node> nodePool = new Hashtable<String, Node>();

	public NodeFactory() {

	}

	public Node newNode(String name, int weight) {
		Node node = nodePool.get(name);
		if (node == null) {
			nodePool.put(name, new Node(name, weight));
			return nodePool.get(name);
		} else {
			if (node.getSelfWeight() == null) {
				node.setSelfWeight(weight);
			}
			return node;
		}

	}

	public Node newNode(String name) {
		Node node = nodePool.get(name);
		if (node == null) {
			nodePool.put(name, new Node(name));
			return nodePool.get(name);
		} else {
			return node;
		}
	}

	public Node findParent() {
		Node parentNode = null;
		Node innerParent = null;
		Enumeration<Node> parentPool = nodePool.elements();
		Enumeration<Node> innerPool ;
		boolean found = false;
		
		while (parentPool.hasMoreElements()) {
			found = false;
			parentNode = parentPool.nextElement();
			innerPool = nodePool.elements();
			while (innerPool.hasMoreElements()) {
				innerParent = innerPool.asIterator().next();
				if ( innerParent.getName().equals(parentNode.getName()) ) {
					continue;
				}
				if ( found ){
					break;
				}
				if (null != innerParent.getChilds()) {
					for (Node node : innerParent.getChilds()) {
						if (node.getName().equals(parentNode.getName())) {
							found = true;
							break;
						}
					}
				} 
			}
			if ( ! found ) {	
				//System.out.println (  "Parent " + parentNode.getName());
				return parentNode;
				 
			}
			
		}
		return null;

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
