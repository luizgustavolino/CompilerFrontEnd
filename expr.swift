
// Expr.swift

class Expr : Node {

	// Expressões matemáticas
	// expr  -> expr + term | expr - term | term
	// term  -> term * unary | term / unary | unary
	// unary -> !unary | -unary | factor
	let op:Token
	let type:Type

	init(withToken tok:Token, type p:Type) {
		op = tok
		type = p
	}

	// Retorna uma outra Expr ou self 
	// de modo que seja uma expressão que 
	// se encaixe no lado direito da notação
	// de três endereços (reduzindo, se necessário)
	func gen() -> Expr {
		return self
	}

	// Reduz uma expressão a um único endereço
	// criando temporárias, se necessário
	// A implementação default considera sendo
	// uma folha (irredutível)
	func reduce()  -> Expr {
		return self
	}

	func jumping(_ t:Int, _ f:Int) {
		emitjumps( toString(), t , f)
	}

	// aqui t -> true ,f -> false
	// Exemplos:
	// A) (x, 5, 2) x ? 5 : 2
	//       if x goto 5
	//       goto 2
	// B) (x, 9, 0)
	//       if goto 9
	// c) (x, 0, 9)
	//       iffalse x goto 9

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


 	// Op pode ser, por exemplo:
 	// Númerico: 10
 	// Token ASCII: + 
 	// Id: t2 
	func toString() -> String {
		return op.toString()
	}

}