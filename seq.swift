

// Seq.swift

class Seq : Stmt {
	
	let stmt1:Stmt
	let stmt2:Stmt

	init(_ s1:Stmt, _ s2:Stmt) {
		stmt1 = s1
		stmt2 = s2
	}

	override func gen(_ b:Int, _ a:Int){
		if stmt1 === Stmt.null {
			stmt2.gen(b, a)
		} else if stmt2 === Stmt.null {
			stmt1.gen(b, a)
		} else {
			let label = newlabel()
			stmt1.gen(b , label)
			emitlabel(label)
			stmt2.gen(label, a)
		}
	}

}