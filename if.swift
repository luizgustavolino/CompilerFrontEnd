
// If.swift

class If : Stmt {
	
	let expr:Expr
	let stmt:Stmt

	// if (x) { s }
	init(_ x:Expr, _ s:Stmt) throws {
		expr = x
		stmt = s
		if expr.type != Type.Bool {
			try expr.error("boolean required in if")
		}
	}

	// b é before
	// a é after
	override func gen(_ b:Int, _ a:Int){

		//  # Quando a != 0
		//  IFFALSE expr.ts() goto a
		// label: 
		//  


		let label = newlabel()
		expr.jumping(0, a)
		emitlabel(label)
		stmt.gen(label, a)		

	}

}