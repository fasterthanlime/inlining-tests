import proof

Container: class <T> {

    data: T*

    init: func (=data) {}

    __inline__get: func (i: Int) -> T {
        data[i]
    }

}


test("container", ||

    arr := [1, 2, 3] as Int*
    cont := Container new(arr)

    for(k in 0..3) {
        val := cont __inline__get(k)
        assert(val == k + 1, "get(%d) should equal %d, but it equals %d" format(k, k + 1, val))
    }

)

