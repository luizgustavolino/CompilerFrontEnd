
// id.swift

class Id : Expr {

	let offset:Int 
	
	init(withID id:Word, type p:Type, offset b:Int) {
		offset = b
		super.init(withToken: id, type:p)
	}

}