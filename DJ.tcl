#Copyright (C) 2011  Wolvendeer
#Released under the terms of the Artistic License 2.0 as published by The Perl Foundation.
#For more information, see "LICENSE" or <http://www.opensource.org/licenses/artistic-license-2.0>

#!/bin/sh
#Includes:
package require BWidget
package require Mk4tcl
source DJ_Procs.tcl

#Initialize database
catch {mk::file open db datafile.mk}
set dr [mk::view layout db.dreams {Title Day Month Year Clarity Lucidity Rating Type PreNotes Dream PostNotes}]
set dri 0

#Theme the application.
option add *Frame.background "#191B33" startupFile
option add *Frame.foreground "#C6C271" startupFile
option add *Listbox.background "#2B2F5F" startupFile
option add *Listbox.foreground "#C6C271" startupFile
option add *ttk::Combobox.background "#2B2F5F" startupFile
option add *Combobox.foreground "#C6C271" startupFile
option add *Button.background "#2B2F5F" startupFile
option add *Button.foreground "#C6C271" startupFile
option add *Entry.background "#2B2F5F" startupFile
option add *Entry.foreground "#C6C271" startupFile
option add *Spinbox.background "#2B2F5F" startupFile
option add *Spinbox.foreground "#C6C271" startupFile
option add *Label.background "#191B33" startupFile
option add *Label.foreground "#C6C271" startupFile
option add *Text.background "#2B2F5F" startupFile
option add *Text.foreground "#C6C271" startupFile

#Build base gui: Tabs, etc.
grid config [ttk::notebook .dj] -column 0 -row 0 -columnspan 10 -rowspan 10 -sticky "snew"
.dj add [frame .dj.dr] -text "Dreams"
.dj add [frame .dj.dc] -text "Dream Characters"
.dj add [frame .dj.ds] -text "Dreamscapes"
ttk::notebook::enableTraversal .dj

#Build Dreams Tab
# #Column 1 - For displaying dreams held by the dream journal.
grid config [frame .dj.dr.l] -row 1 -column 1 -sticky "snew"
grid config [Tree .dj.dr.l.tree] -row 1 -column 1 -rowspan 4 -sticky "snew"

# #Column 2 - For actual content.  Title, date, dream description, etc.
grid config [frame .dj.dr.c] -row 1 -column 2 -sticky "snew"
grid config [label .dj.dr.c.ltitle -text "Title"] -row 1 -column 2 -sticky "n"
grid config [entry .dj.dr.c.title] -row 1 -column 3 -sticky "new"
grid config [label .dj.dr.c.lday -text "Day"] -row 1 -column 4 -sticky "n"
grid config [spinbox .dj.dr.c.day -width 3 -from 1 -to 31 -increment 1] -row 1 -column 5 -sticky "new"
grid config [label .dj.dr.c.lmonth -text "Mo"] -row 1 -column 6 -sticky "n"
grid config [spinbox .dj.dr.c.month -width 3 -from 1 -to 12 -increment 1] -row 1 -column 7 -sticky "new"
grid config [label .dj.dr.c.lyear -text "Year"] -row 1 -column 8 -sticky "n"
grid config [spinbox .dj.dr.c.year -width 4 -from 1950 -to 2050 -increment 1] -row 1 -column 9 -sticky "new"
grid config [label .dj.dr.c.lclarity -text "Clarity"] -row 1 -column 10 -sticky "n"
grid config [spinbox .dj.dr.c.clarity -width 3 -from 0 -to 5 -increment 1] -row 1 -column 11 -sticky "new"
grid config [label .dj.dr.c.llucidity -text "Lucidity"] -row 1 -column 12 -sticky "n"
grid config [spinbox .dj.dr.c.lucidity -width 3 -from -2 -to 3 -increment 1] -row 1 -column 13 -sticky "new"
grid config [label .dj.dr.c.lrating -text "Rating"] -row 1 -column 14 -sticky "n"
grid config [spinbox .dj.dr.c.rating -width 3 -from 0 -to 5 -increment 1] -row 1 -column 15 -sticky "new"
grid config [label .dj.dr.c.ltag -text "Tags"] -row 2 -column 2 -sticky "w"
grid config [entry .dj.dr.c.tag] -row 2 -column 3 -columnspan 3 -sticky "ew"
grid config [label .dj.dr.c.ltype -text "Type"] -row 2 -column 6 -sticky "w"
grid config [ComboBox .dj.dr.c.type -values [list "Normal (ND)" "Lucid (LD)" "Nightmare" "Meditation"]] -row 2 -column 7 -columnspan 3 -sticky "ew"
grid config [button .dj.dr.c.dc -text "DC"] -row 2 -column 10 -sticky "ne"
grid config [button .dj.dr.c.ds -text "Dreamscapes"] -row 2 -column 11 -columnspan 2 -sticky "nw"
grid config [text .dj.dr.c.dream] -row 3 -column 2 -columnspan 15 -sticky "snew"
grid config [button .dj.dr.c.save -text "Save" -command {drsave $dr!$dri $drnew}] -row 4 -column 12 -sticky "ne"

# #Column 3 - For descriptive content such as tags, lucidity, rating, etc.
grid config [frame .dj.dr.r] -row 1 -column 3 -sticky "snew"
grid config [button .dj.dr.r.button1 -text "Button 1"] -row 1 -column 1 -sticky "snew"
grid config [label .dj.dr.r.label1 -text "Label 1"] -row 2 -column 1 -sticky "snew"
grid config [button .dj.dr.r.button2 -text "Button 2"] -row 3 -column 1 -sticky "snew"
grid config [label .dj.dr.r.label2 -text "Label 2"] -row 4 -column 1 -sticky "snew"
grid config [button .dj.dr.r.button3 -text "Button 3"] -row 5 -column 1 -sticky "snew"
grid config [label .dj.dr.r.label3 -text "Label 3"] -row 6 -column 1 -sticky "snew"
# # #We need a function that will be passed its caller and show the caller's items while hiding the items of the previously open button.

#Grid Configuration
grid columnconfigure . 0 -weight 1
grid columnconfigure .dj.dr 1 -weight 1
grid columnconfigure .dj.dr 2 -weight 4
grid columnconfigure .dj.dr 3 -weight 1
grid columnconfigure .dj.dr.l 1 -weight 1
grid columnconfigure .dj.dr.c 3 -weight 4
grid columnconfigure .dj.dr.r 1 -weight 1

grid rowconfigure . 0 -weight 1
grid rowconfigure .dj.dr 1 -weight 1
grid rowconfigure .dj.dr.l 1 -weight 1
grid rowconfigure .dj.dr.c 3 -weight 4

#Initialize Dreams Tab
foreach i [mk::select $dr] {
	global $dri
	set dri $i
	filltree .dj.dr.l.tree $dr!$dri
}
set drnew true
.dj.dr.c.day set [clock format [clock seconds] -format {%d}]
.dj.dr.c.month set [clock format [clock seconds] -format {%m}]
.dj.dr.c.year set [clock format [clock seconds] -format {%Y}]

#Closing statements
#mk::file close db