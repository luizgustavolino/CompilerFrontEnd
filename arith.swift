

// Arith.swift

class Arith : Op {

	let expr1:Expr
	let expr2:Expr

	init(withToken tok:Token,_ x1:Expr,_ x2:Expr) {

		expr1 = x1
		expr2 = x2

		if let type = Type.max(expr1.type, expr2.type) {
			super.init(withToken:tok, type: type)	
		}else{
			fatalError("type error!")
		}
	}

	override func gen() -> Expr {
		return Arith(withToken: op, expr1.reduce(), expr2.reduce())
	}

	override func toString() -> String {
		return "\(expr1.toString()) \(op.toString()) \(expr2.toString())"
	}
}