use proof
import proof

import structs/List

/**
   Resizable-array implementation of the List interface. Implements all
   optional list operations, and permits all elements, including null.

   In addition to implementing the List interface, this class provides
   methods to manipulate the size of the array that is used internally
   to store the list.

   :author: Amos Wenger (nddrylliog)
 */
ArrayList: class <T> extends List<T> {

	data : T*
	capacity : Int
	size = 0 : Int

	init: func {
		init(10)
	}

	init: func ~withCapacity (=capacity) {
		data = gc_malloc(capacity * T size)
	}

    init: func ~withData (.data, =size) {
        this data = gc_malloc(size * T size)
        memcpy(this data, data, size * T size)
        capacity = size
    }

	add: func (element: T) {
		ensureCapacity(size + 1)
		data[size] = element
		size += 1
	}

	add: func ~withIndex (index: Int, element: T) {
        // inserting at 0 can be optimized
		if(index == 0) {
            ensureCapacity(size + 1)
            dst, src: Octet*
            dst = data + (T size)
            src = data
            memmove(dst, src, T size * size)
            data[0] = element
            size += 1
            return
        }

        if(index == size) {
            add(element)
            return
        }

        checkIndex(index)
		ensureCapacity(size + 1)
		dst, src: Octet*
		dst = data + (T size * (index + 1))
		src = data + (T size * index)
		bsize := (size - index) * T size
		memmove(dst, src, bsize)
		data[index] = element
		size += 1
	}

	clear: func {
		size = 0
	}

    get: func (index: Int) -> T {
        checkIndex(index)
		return data[index]
    }

	__inline__get: func(index: Int) -> T {
		checkIndex(index)
		return data[index]
	}

	indexOf: func(element: T) -> Int {
		index := 0
		while(index < size) {
			//if(memcmp(data + index * T size, element, T size) == 0) return index
            if(this as List equals?(this[index], element)) return index
            index += 1
		}
		return -1
	}

	lastIndexOf: func(element: T) -> Int {
		index := size
		while(index > -1) {
			if(memcmp(data + index * T size, element, T size) == 0) return index
			index -= 1
		}
		return -1
	}

	removeAt: func (index: Int) -> T {
		element := data[index]
        memmove(data + (index * T size), data + ((index + 1) * T size), (size - index) * T size)
		size -= 1
		return element
	}

    /**
     * Does an in-place sort, with the given comparison function
     */
    sort: func (greaterThan: Func (T, T) -> Bool) {
        inOrder := false
        while (!inOrder) {
            inOrder = true
            for (i in 0..size - 1) {
                if (greaterThan(this[i], this[i + 1])) {
                    inOrder = false
                    tmp := this[i]
                    this[i] = this[i + 1]
                    this[i + 1] = tmp
                }
            }
        }
    }

	/**
	 * Removes a single instance of the specified element from this list,
	 * if it is present (optional operation).
	 * @return true if at least one occurence of the element has been
	 * removed
	 */
	remove: func (element: T) -> Bool {
		index := indexOf(element)
		if(index == -1) return false
		else {
			removeAt(index)
		}
		return true
	}

	/**
	 * Replaces the element at the specified position in this list with
	 * the specified element.
	 */
	set: func(index: Int, element: T) -> T {
        checkIndex(index)
        old := data[index]
		data[index] = element
        old
	}

	/**
	 * @return the number of elements in this list.
	 */
	size: inline func -> Int { size }

	/**
	 * Increases the capacity of this ArrayList instance, if necessary,
	 * to ensure that it can hold at least the number of elements
	 * specified by the minimum capacity argument.
	 */
	ensureCapacity: inline func (newSize: Int) {
		if(newSize > capacity) {
			capacity = newSize * (newSize > 50000 ? 2 : 4)
            tmpData := gc_realloc(data, capacity * T size)
            if (tmpData) {
                data = tmpData
            } else {
                Exception new(This, "Failed to allocate %zu bytes of memory for array to grow! Exiting..\n" format(capacity * T size)) throw()
            }
		}
	}

	/** private */
	checkIndex: inline func (index: Int) {
		if (index < 0) {
            Exception new(This, "Index too small! " + index + " < 0") throw()
        }
		if (index >= size) {
            Exception new(This, "Index too big! " + index + " >= " + size()) throw()
        }
	}

	iterator: func -> BackIterator<T> { return ArrayListIterator<T> new(this) }

	backIterator: func -> BackIterator<T> {
	    iter := ArrayListIterator<T> new(this)
	    iter index = size()
	    return iter
	}

	clone: func -> This<T> {
		copy := This<T> new(size())
		copy addAll(this)
		return copy
	}

    emptyClone: func <K> -> This<K> {
        This<K> new()
    }

    /** */
    toArray: func -> Pointer { data }

}

ArrayListIterator: class <T> extends BackIterator<T> {

	list: ArrayList<T>
	index := 0

	init: func ~iter (=list) {}

	hasNext?: func -> Bool { index < list size() }

	next: func -> T {
		element := list get(index)
		index += 1
		return element
	}

    hasPrev?: func -> Bool { index > 0 }

    prev: func -> T {
        index -= 1
		element := list get(index)
		return element
	}

    remove: func -> Bool {
        if(list removeAt(index - 1) == null) return false
        if(index <= list size()) index -= 1
        return true
    }

}

test("arraylist", ||

    list := ArrayList<Int> new()
    for(k in 0..3) list add(k)

    for(k in 0..3) {
        val := list __inline__get(k)
        assert(val == k + 1)
    }

)

