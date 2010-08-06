import proof

__inline__choose: func <T> (b: Bool, t1, t2: T) -> T {
    if(b)
        t1
    else
        t2
}

test("whiteblack", ||
    assert ("white" == __inline__choose(true , "white", "black"))
    assert ("black" == __inline__choose(false, "white", "black"))
)
