import sys

def formatTitle(title):
    tLen = len(title)
    headline = ';;'
    
    middle = int((headlen - 4) / 2)
    spacesBefore = middle - int(tLen / 2)
    spacesAfter = (headlen - 4) - (spacesBefore + tLen)

    headline += ' ' * spacesBefore
    headline += title
    headline += ' ' * spacesAfter
    headline += ';;'
    return headline

headlen = int(sys.argv[1])
titles = sys.argv[2:]

for t in titles:
    if len(t) > headlen:
        headlen = len(t)


separator = ';; ' + ('=' * (headlen - 6)) + ' ;;'

for t in titles:
    print(separator)
    print(formatTitle(t))
    print(separator)
