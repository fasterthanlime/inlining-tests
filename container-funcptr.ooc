use proof
import proof

Container: class <T> {

    data: T*
    length: Int

    equals?: Func (T, T) -> Bool

    init: func (=data, =length, =equals?) {}

    __inline__indexOf: func (element: T) -> Int {
        for(i in 0..length) {
            if(equals?(data[i], element)) {
                return i
            }
        }
        -1
    }

}


test("container-funcptr", ||

    arr := [1, 2, 3] as Int*
    cont := Container new(arr, 3, |a, b| a == b)

    for(k in 0..cont length) {
        idx := cont __inline__indexOf(k + 1)
        assert(idx == k, "indexOf(%d) should equal %d, but it equals %d" format(k + 1, k,  idx))
    }

)

