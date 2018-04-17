

// Break.swift

class Break : Stmt {
	
	let stmt:Stmt 

	override init() {
		
		stmt = Stmt.Enclosing		
		super.init()

		if Stmt.Enclosing === Stmt.null {
			try? error("enenclosed break")
		}

	}

	override func gen(_ b:Int, _ a:Int) {
		emit("goto L\(stmt.after)")
	}

}