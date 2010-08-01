use proof
import proof

Container: class <T> {

    data: T*
    size: Int

    init: func (=data, =size) {}

    __inline__get: func (i: Int) -> T {
        data[i]
    }

    last: func -> T {
        __inline__get(size - 1)
    }

}


test("last", ||

    arr := [1, 2, 3] as Int*
    cont := Container new(arr, 3)

    assert(cont last() == 3)

)

