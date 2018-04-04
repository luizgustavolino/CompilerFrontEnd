
// Expr.swift

class Expr : Node {

	let op:Token
	let type:Type

	init(withToken tok:Token, type p:Type) {
		op = tok
		type = p
	}

	func gen() -> Expr {
		return self
	}

	func reduce()  -> Expr {
		return self
	}

	func jumping(_ t:Int, _ f:Int) {
		emitjumps( toString(), t , f)
	}

	// aqui t -> true ,f -> false
	func emitjumps(_ test:String, _ t:Int, _ f:Int) {
		if t != 0 && f != 0 {
			emit("if \(test) goto L\(t)")
			emit("goto :\(f)")
		} else if t != 0 {
			emit("if \(test) goto L\(t)")
		} else if f != 0 {
			emit("iffalse \(test) goto L\(f)")
		}
	}

	func toString() -> String {
		return op.toString()
	}

}