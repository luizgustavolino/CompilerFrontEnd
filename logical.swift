
// Logical.swift

class Logical : Expr {

	let expr1:Expr
	let expr2:Expr

	// true && false
	// (Word("&&"), Expr(Type.Bool(true)), Expr(Type.Bool(false)))
	init(withToken tok:Token, _ x1:Expr, _ x2:Expr) {

		expr1 = x1
		expr2 = x2

		if let _ = Logical.check(expr1.type, expr2.type) {
			super.init(withToken:tok, type: x1.type)
        }else{
			fatalError("logical type error!")
        }

	}

	static func check(_ p1:Type, _ p2:Type) -> Type? {
		if p1 == Type.Bool && p2 == Type.Bool {
			return Type.Bool 
		}else{
			return nil
		}
	}


	// Reduz para uma Expr que caiba à direita
	// da notação de 3 endereços
	override func gen() -> Expr {

		let f = newlabel()
		let a = newlabel()
		let temp = Temp(withType: type)

		//  IFFALSE self GOTO Lf
		//  t3 = true 
		//  goto La
		// Lf:
		//  t3 = false 
		// La:
		// 
		// (continua...)

		jumping(0, f) 

		emit("\(temp.toString()) = true")
		emit("goto L\(a)")

		emitlabel(f)
		emit("\(temp.toString()) = false")

		emitlabel(a)

		return temp
	}

	override func toString() -> String {
		return "\(expr1.toString()) \(op.toString()) \(expr2.toString())"
	}

}
