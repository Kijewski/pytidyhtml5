from os.path import basename, dirname
from sys import argv


BUILDING_DOC = (basename(argv[0]) in (
    'sphinx-build',
)) or (basename(dirname(argv[0])) in (
    'sphinx',
))
