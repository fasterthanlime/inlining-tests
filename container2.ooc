import proof

Container2: class <T> {

    data: T*
    length: Int

    init: func (=data, =length) {}

    __inline__get: func (i: Int) -> T {
        checkIndex(i)
        data[i]
    }

    checkIndex: func (i: Int) {
        if(i < 0 || i >= length) {
            Exception new(This, "Index out of bounds, 0 > %d >= length=%d" format(i, length))
        }
    }

}


test("container2", ||

    arr := [1, 2, 3] as Int*
    cont := Container2 new(arr, 3)

    for(k in 0..3) {
        val := cont __inline__get(k)
        assert(val == k + 1, "get(%d) should equal %d, but it equals %d" format(k, k + 1, val))
    }

)

