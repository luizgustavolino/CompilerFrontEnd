
// While.swift

class While : Stmt {

	var expr:Expr?
	var stmt:Stmt?

	override init(){
		expr = nil
		stmt = nil 
	}

	func set(_ x:Expr, _ s:Stmt) throws {
		expr = x
		stmt = s

		if x.type != Type.Bool {
			try x.error("boolean required in while")
		}
	}

	override func gen(_ b:Int, _ a:Int){

		guard let expr = expr,
			  let stmt = stmt else {
			return 
		}

		after = a
		expr.jumping(0, a)

		let label = newlabel()
		emitlabel(label)
		stmt.gen(label, b)

		emit("goto L\(b)")
	}

}