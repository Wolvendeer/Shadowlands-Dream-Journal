proc filltree {&tree vwcurse} {
		global ${&tree}
		set Year [mk::get $vwcurse Year]
		set Month [mk::get $vwcurse Month]
		set Day [mk::get $vwcurse Day]
		
		if {[Tree::exists ${&tree} .$Year]} {
			if {[Tree::exists ${&tree} .$Year.$Month]} {
				if {[Tree::exists ${&tree} .$Year.$Month.$Day]} {
					Tree::insert ${&tree} end .$Year.$Month.$Day .$Year.$Month.$Day.#auto -text [mk::get $vwcurse Title] -data [mk::cursor position vwcurse]
				} else {
					Tree::insert ${&tree} end .$Year.$Month .$Year.$Month.$Day -text $Day
					Tree::insert ${&tree} end .$Year.$Month.$Day .$Year.$Month.$Day.#auto -text [mk::get $vwcurse Title] -data [mk::cursor position vwcurse]
				}
			} else {
				Tree::insert ${&tree} end .$Year .$Year.$Month -text $Month
				Tree::insert ${&tree} end .$Year.$Month .$Year.$Month.$Day -text $Day
				Tree::insert ${&tree} end .$Year.$Month.$Day .$Year.$Month.$Day.#auto -text [mk::get $vwcurse Title] -data [mk::cursor position vwcurse]
			}
		} else {
			Tree::insert ${&tree} end root .$Year -text  $Year
			Tree::insert ${&tree} end .$Year .$Year.$Month -text $Month
			Tree::insert ${&tree} end .$Year.$Month .$Year.$Month.$Day -text $Day
			Tree::insert ${&tree} end .$Year.$Month.$Day .$Year.$Month.$Day.#auto -text [mk::get $vwcurse Title] -data [mk::cursor position vwcurse]
		}
}

proc drsave {drcurse neu} {
	if {$neu} {
		mk::row insert $drcurse 1 [mk::row create Title [.dj.dr.c.title get] Day [.dj.dr.c.day get] Month [.dj.dr.c.month get] Year [.dj.dr.c.year get] Clarity [.dj.dr.c.clarity get] Lucidity [.dj.dr.c.lucidity get] Rating [.dj.dr.c.rating get] Type [.dj.dr.c.type get] PreNotes "" Dream [.dj.dr.c.dream get 1.0 end] PostNotes ""]
		#filltree .dj.dr.l.tree $Gdrcurse
	} else {
		mk::row replace $drcurse [mk::row create Title [.dj.dr.c.title get] Day [.dj.dr.c.day get] Month [.dj.dr.c.month get] Year [.dj.dr.c.year get] Clarity [.dj.dr.c.clarity get] Lucidity [.dj.dr.c.lucidity get] Rating [.dj.dr.c.rating get] Type [.dj.dr.c.type get] PreNotes "" Dream [.dj.dr.c.dream get 1.0 end] PostNotes ""]
	}
}