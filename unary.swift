
// Unary.swift

class Unary : Op {
	
	let expr:Expr


	// Tratamento do sinal de "-" nos números 
	// negativos 
	init(withToken tok:Token, _ x:Expr) {

		expr = x

		if let type = Type.max(Type.Int, expr.type) {
			super.init(withToken:tok, type: type)	
		}else{
			fatalError("type error!")
		}
	}

	// exemplo:
	//   -(3 + 5)
	// gera:
	//   t2 = 3 + 5
	//   -t2
	override func gen() -> Expr {
		return Unary(withToken: op, expr.reduce())
	}

	override func toString() -> String {
		return "\(op.toString()) \(expr.toString())" 
	}
}