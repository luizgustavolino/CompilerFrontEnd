
// Do.swift

class Do : Stmt {

	var expr:Expr?
	var stmt:Stmt?

	override init(){
		expr = nil
		stmt = nil 
	}

	func set(_ s:Stmt, _ x:Expr) throws {

		expr = x
		stmt = s

		if x.type != Type.Bool {
			try x.error("boolean required in do")
		}
	}

	override func gen(_ b:Int, _ a:Int){

		guard let expr = expr,
			  let stmt = stmt else {
			return 
		}

		after = a
		let label = newlabel()
		stmt.gen(b , label)
		
		emitlabel(label)
		expr.jumping(b, 0)
		
	}

}	
