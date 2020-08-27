---
title: "Applicazion Dictionary"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 50
pre: "<b> </b>"
---
How to Application dictionary

Display Logic

If the Field is displayed, the result determines if the field is actually displayed

format := {expression} [{logic} {expression}]

expression := @{context}@{operand}{value} or @{context}@{operand}{value}

logic := {|}|{&}

context := any global or window context 

value := strings or numbers

logic operators	:= AND or OR with the previous result from left to right 

operand := eq{=}, gt{>}, le{<}, not{~^!} 

Examples: 

@AD_Table_ID@=14 | @Language@!GERGER 

@PriceLimit@>10 | @PriceList@>@PriceActual@

@Name@>J

Strings may be in single quotes (optional)

[[Category:Developer]]

