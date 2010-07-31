use proof
import proof

__inline__getNth: func <T> (array: T*, n: Int) -> T {
    array[n]
}

test("getnth", ||
    arr := [1, 2, 3] as Int*

    for(i in 0..3) {
        assert(arr[i] == __inline__getNth(arr, i))
    }
)
