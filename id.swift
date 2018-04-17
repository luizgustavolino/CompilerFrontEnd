
// id.swift

class Id : Expr {

	let offset:Int 
	
	// ID é uma folha, offset  é o endereço relativo
	init(withID id:Word, type p:Type, offset b:Int) {
		offset = b
		super.init(withToken: id, type:p)
	}

}