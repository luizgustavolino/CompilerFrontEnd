
// Stmt.swift

class Stmt : Node {

	static let null = Stmt()

	// Stmt mais acima, para break
	static var Enclosing = Stmt.null
	
	var after = 0
 	
 	func gen(_ a:Int,_ b:Int) {
 		// sem emite, neste caso
 		// implementado nas subclasses
 	}

}