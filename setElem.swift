

// SetElem.swift


class SetElem : Stmt {
	
	let array:Id
	let index:Expr
	let expr:Expr

	init(_ x:Access, _ y:Expr) throws {
		array = x.array
		index = x.index
		expr = y

		super.init()

		if check(x.type, expr.type) == nil {
			try error("type error")
		}
	}

	func check(_ p1:Type, _ p2:Type) -> Type? {
		if p1 is Arrayy || p2 is Arrayy {
			return nil
		} else if p1 == p2 {
			return p2
		} else if Type.numeric(p1) && Type.numeric(p2) {
			return p2
		}else {
			return nil
		}
	}

	override func gen(_ b:Int, _ a:Int) {
		let s1 = index.reduce().toString()
		let s2 = expr.reduce().toString()
		emit(array.toString() + "[" + s1 + "] = " + s2)
	}

}