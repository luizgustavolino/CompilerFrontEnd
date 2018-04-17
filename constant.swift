
// Constant.swift

class Constant : Expr {
	
	convenience init(_ i:Int){
		self.init(withToken: Num(withValue: i), type:Type.Int)
	}

	static let True  = Constant(withToken: Word.True, type: Type.Bool)
	static let False = Constant(withToken: Word.False, type: Type.Bool)

	//  jumping(4,0) com token = true  -> GOTO 4
	//  jumping(0,6) com token = false -> GOTO 6
	//  jumping(4,0) com token = false -> 
	override func jumping(_ t:Int, _ f:Int) {
		if op == Word.True && t != 0 {
			emit("goto L\(t)")
		} else if op == Word.False && f != 0 {
			emit("goto L\(f)")
		}
	}

}