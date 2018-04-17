
// Not.swift

class Not : Logical {

	init(withToken tok:Token, _ x2:Expr) {
		super.init(withToken: tok, x2, x2)
	}

	// Aqui ele inverte o fluxo
	// Trocando a caminho de false para true 
	// e de true para false
	override func jumping(_ t:Int,_ f:Int) {
		expr2.jumping(f, t)
	}

	override func toString() -> String {
		return "\(op.toString()) \(expr2.toString())"
	}

}