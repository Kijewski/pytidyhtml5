import os
import sys

sys.path.insert(0, os.path.abspath(".."))

import pytidyhtml5


extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.autosummary",
    "sphinx.ext.napoleon",
    "sphinx.ext.intersphinx",
    "sphinx_autodoc_typehints",
    "sphinx.ext.autosectionlabel",
]

templates_path = ["_templates"]

source_suffix = ".rst"

master_doc = "index"

project = "PyTidyHTML5"
copyright = "2019-2024, René Kijewski"
author = "René Kijewski"

with open(os.path.join(os.path.abspath(".."), "lib", "VERSION.txt"), "rt") as f:
    # The full version, including alpha/beta/rc tags.
    release = eval(f.read())
    # The short X.Y version.
    version = release  # '.'.join(release.split('.', 2)[:2])

language = "en"

exclude_patterns = []

pygments_style = "sphinx"

todo_include_todos = False

html_theme = "sphinx_rtd_theme"

html_theme_options = {
    "navigation_depth": -1,
}

html_sidebars = {
    "**": [
        "localtoc.html",
        "searchbox.html",
    ]
}

htmlhelp_basename = "PyTidyHtml5doc"

display_toc = True
autodoc_default_flags = ["members"]
autosummary_generate = True

intersphinx_mapping = {
    "python": ("https://docs.python.org/3", None),
}
