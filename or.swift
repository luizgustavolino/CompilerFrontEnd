

// Or.swift

class Or : Logical {


	// ( A || B ) {
	//	
	// }
	override func jumping(_ t:Int,_ f:Int) {

		// IF self GOTO label

		let label = t != 0 ? t : newlabel()

		// label nunca é zero
		expr1.jumping(label, 0)
		expr2.jumping(t, f)

		if t == 0 {
			emitlabel(label)
		}
	}

}