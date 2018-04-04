
// Node.swift

class Node {

	let lexline:Int
	static var labels = 0

	init(){
		lexline = Lexer.line
	}

	enum Errors : Error {
		case generic 
	} 

	func error(_ s:String) throws {
		throw Errors.generic
	}

	func newlabel() -> Int {
		Node.labels += 1
		return Node.labels
	}

	func emitlabel(_ i:Int) {
		print("L\(i):")
	}

	func emit(_ s:String) {
		print("\t\(s)")
	}

}