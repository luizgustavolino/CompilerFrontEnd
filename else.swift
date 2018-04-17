
// Else.swift

class Else : Stmt {
	
	let expr:Expr
	let stmt1:Stmt
	let stmt2:Stmt

	init(_ x:Expr, _ s1:Stmt, _ s2:Stmt) throws {
		expr = x
		stmt1 = s1
		stmt2 = s2
		if expr.type != Type.Bool {
			try expr.error("boolean required in if")
		}
	}

	override func gen(_ a:Int, _ b:Int) {
		let label1 = newlabel()
		let label2 = newlabel()
		
		expr.jumping(0, label2)

		emitlabel(label1)
		stmt1.gen(label1, a)
		emit("goto L\(a)")

		emitlabel(label2)
		stmt2.gen(label2, a)
	}

}