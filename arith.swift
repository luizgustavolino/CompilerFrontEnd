

// Arith.swift

class Arith : Op {

	let expr1:Expr
	let expr2:Expr

	// Operações Aritiméticas
	// Exemplo: 3 + 4 - 7
	// ( Word(+), Expr(Num(3)), Arith( Word(-), Num(4), Num(7)) )
	init(withToken tok:Token, _ x1:Expr, _ x2:Expr) {

		expr1 = x1
		expr2 = x2

		// Max retorna o tipo predominante
		// ex: float , int - > float
		if let type = Type.max(expr1.type, expr2.type) {
			super.init(withToken:tok, type: type)	
		}else{
			fatalError("type error!")
		}
	}

	// Reduz operações compostas para uma 
	// operação que caiba numa notação de 3 end.
	override func gen() -> Expr {
		return Arith(withToken: op, expr1.reduce(), expr2.reduce())
	}

	// emite, por exemplo:
	// 3 + 2
	// t2 + 5
	// t5 + t6
	override func toString() -> String {
		return "\(expr1.toString()) \(op.toString()) \(expr2.toString())"
	}
}