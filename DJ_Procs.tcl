#Richard Suchenwirth 2002-11-07 from: http://wiki.tcl.tk/4535
proc pruc {name argl body} {
    set prefix ""
    foreach {upvar var} [regexp -all -inline {[*&]([^ ]+)} $argl] {
	append prefix "\nupvar 1 \${$upvar} $var;"
    }
    proc $name $argl $prefix$body
}

pruc filltree {&tree &db} {
	
}