function (hex2dec hex output)

    string(TOLOWER ${hex} hex)
    string(LENGTH ${hex} sizeOfHex)
    math(EXPR loopCounter "${sizeOfHex} -1")
    set(dec 0)
    set(power 1)

    foreach (i RANGE ${loopCounter} 0 -1)
        string(SUBSTRING ${hex} ${i} 1 char)

        if(${char} STREQUAL "a")
            set(char 10)
        elseif(char STREQUAL "b")
            set(char 11)
        elseif(char STREQUAL "c")
            set(char 12)
        elseif(char STREQUAL "d")
            set(char 13)
        elseif(char STREQUAL "e")
            set(char 14)
        elseif(char STREQUAL "f")
            set(char 15)
        endif()

        math(EXPR dec "${dec} + ${char}*${power}")
        set(power ${power}*16)
        math(EXPR power "${power}")
    endforeach ()

    set (${output} ${dec} PARENT_SCOPE)
endfunction ()
