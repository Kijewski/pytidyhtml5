#!/usr/bin/env python3

from pytidyhtml5 import (
    AttrSortStrategy,
    LineEnding,
    OptionId,
    set_language,
    tidy_document,
)


options = {
    OptionId.alt_text: "",
    OptionId.doctype: "html5",
    OptionId.drop_empty_elems: False,
    OptionId.drop_empty_paras: False,
    OptionId.fix_backslash: False,
    OptionId.force_output: True,
    OptionId.hide_comments: True,
    OptionId.html_out: True,
    OptionId.indent_attributes: False,
    OptionId.indent_cdata: False,
    OptionId.indent_content: False,
    OptionId.indent_spaces: 0,
    OptionId.join_classes: True,
    OptionId.join_styles: True,
    OptionId.mark: False,
    OptionId.merge_divs: False,
    OptionId.merge_emphasis: False,
    OptionId.merge_spans: False,
    OptionId.meta_charset: True,
    OptionId.newline: LineEnding.crlf,
    OptionId.num_entities: True,
    OptionId.quote_ampersand: True,
    OptionId.quote_marks: True,
    OptionId.quote_nbsp: True,
    OptionId.sort_attributes: AttrSortStrategy.alpha,
}

set_language("de")

expected = (
    '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n<meta charset="utf-8">\r\n<title></title>\r\n</head>\r\n<body>\r\nHall&#246;chen\r\n</body>\r\n</html>\r\n',
    "Zeile 1 Spalte 1 - Warnung: fehlende <!DOCTYPE> Deklaration\nZeile 1 Spalte 1 - Warnung: Klartext ist im Element <head> nicht erlaubt\nZeile 1 Spalte 1 - Info: <head> bereits vermerkt\nZeile 1 Spalte 1 - Warnung: füge implizites <body> ein\nZeile 1 Spalte 1 - Warnung: füge fehlendes 'title' Element ein\nZeile 1 Spalte 10 - Info: Fehlendes <meta charset=...> wurde in <head> hinzugefügt\n",
)
actual = tidy_document("Hallöchen", options=options)

if expected != actual:
    print("actual=" + repr(actual))
    raise SystemExit(1)

print("OK")
