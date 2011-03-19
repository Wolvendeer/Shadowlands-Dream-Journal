#Richard Suchenwirth 2002-11-07 from: http://wiki.tcl.tk/4535
proc pruc {name argl body} {
    set prefix ""
    foreach {upvar var} [regexp -all -inline {[*&]([^ ]+)} $argl] {
	append prefix "\nupvar 1 \${$upvar} $var;"
    }
    proc $name $argl $prefix$body
}

pruc filltree {&tree &vwcurse} {
	mk::loop vwcurse {
		set Year [mk::get vwcurse Year]
		set Month [mk::get vwcurse Month]
		set Day [mk::get vwcurse Day]
		
		if {$tree exists .$Year} {
			if {$tree exists .$Year.$Month} {
				if {$tree exists .$Year.$Month.$Day} {
					$tree insert end .$Year.$Month.$Day .$Year.$Month.$Day.#auto -text [mk::get vwcurse Title] -data [mk::cursor position vwcurse]
				} else {
					$tree insert end .$Year.$Month .$Year.$Month.$Day -text $Day
					$tree insert end .$Year.$Month.$Day .$Year.$Month.$Day.#auto -text [mk::get vwcurse Title] -data [mk::cursor position vwcurse]
				}
			} else {
				$tree insert end .$Year .$Year.$Month -text $Month
				$tree insert end .$Year.$Month .$Year.$Month.$Day -text $Day
				$tree insert end .$Year.$Month.$Day .$Year.$Month.$Day.#auto -text [mk::get vwcurse Title] -data [mk::cursor position vwcurse]
			}
		} else {
			$tree insert end root .$Year -text $Year
			$tree insert end .$Year .$Year.$Month -text $Month
			$tree insert end .$Year.$Month .$Year.$Month.$Day -text $Day
			$tree insert end .$Year.$Month.$Day .$Year.$Month.$Day.#auto -text [mk::get vwcurse Title] -data [mk::cursor position vwcurse]
		}
	}
}

proc drsave {} {
	
}