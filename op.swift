
// Op.swift

class Op : Expr {

	// Basicamente:
	// gen() de self vai transformar self em
	// um Expr que cabe no lado direito
	// da notação de três endereço
	// t5 = 4 + 2
	// t6 = 3 + 3
	// t7 = t5 + t6
	override func reduce() -> Expr {
		let x = gen()
		let t = Temp(withType: type)
		emit("\(t.toString()) = \(x.toString())")
		return t
	}

}
