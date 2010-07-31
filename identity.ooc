import proof

__inline__identity: func <T> (t: T) -> T {
    t
}

test("identity", ||
    assert ("42" == 42 toString())
    assert ("42" == __inline__identity(42) toString())
)
