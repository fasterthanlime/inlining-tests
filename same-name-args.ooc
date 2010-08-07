use proof
import proof

__inline__getNth: func <T> (array: T*, n: Int) -> T {
    array[n]
}

test("same-name-args", ||
    array := [1, 2, 3] as Int*

    for(i in 0..3) {
        assert(array[i] == __inline__getNth(array, i))
    }
)
