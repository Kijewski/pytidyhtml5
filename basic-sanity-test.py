#!/usr/bin/env python3

import pytidyhtml5

pytidyhtml5.set_language('de')
expected = (
    '<!DOCTYPE html>\n<html>\n<head>\n<meta name="generator" content="HTML Tidy for HTML5 for Linux version 5.8.0">\n<title></title>\n</head>\n<body>\nHall&ouml;chen\n</body>\n</html>\n',
    "Zeile 1 Spalte 1 - Warnung: fehlende <!DOCTYPE> Deklaration\nZeile 1 Spalte 1 - Warnung: Klartext ist im Element <head> nicht erlaubt\nZeile 1 Spalte 1 - Info: <head> bereits vermerkt\nZeile 1 Spalte 1 - Warnung: füge implizites <body> ein\nZeile 1 Spalte 1 - Warnung: füge fehlendes 'title' Element ein\n"
)
actual = pytidyhtml5.tidy_document('Hallöchen')
if expected != actual:
    print('actual=' + repr(actual))
    raise SystemExit(1)

print('OK')
