

// Set.swift

class Set : Stmt {

	let id:Id
	let expr:Expr

	init(_ i:Id, _ x:Expr) throws {

		id = i
		expr = x
		super.init()

		if check(id.type, expr.type) == nil {
			try error("type error")
		}

	}

	func check(_ p1:Type, _ p2:Type) -> Type? {
		if Type.numeric(p1) && Type.numeric(p2) {
			return p2
		} else if p1 == Type.Bool && p2 == Type.Bool {
			return p2
		}  else {
			return nil
		}
	}

	override func gen(_ b:Int, _ a:Int){
		emit("\(id.toString()) = \(expr.gen().toString())")
	}

}