# Run with: sh awkro.sh awkro-sample

awk '# awkro - expand acronyms
# load acronyms file into array "acro"
FILENAME == "acronyms" {
    split($0, entry, "\t")
    acro[entry[1]] = entry[2]
    next
}
# process any input line containing caps
/[A-Z][A-Z]+/ {
    # see if any field is an acronym
    for (i = 1; i <= NF; i++)
        if ($i in acro) {
            # if it matches, add description
            # here we change the original content assigning the new value to `$i`
            $i = acro[$i] " (" $i ")"
        }
    }
{
    # print all lines
    print $0
}' acronyms $*
