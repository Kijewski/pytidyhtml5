cdef void *allocator_realloc_raw(TidyAllocator *self, void *block, size_t nBytes) noexcept nogil:
    return PyMem_RawRealloc(block, nBytes)


cdef void *allocator_realloc_gil(TidyAllocator *self, void *block, size_t nBytes) noexcept nogil:
    cdef void *result
    with gil:
        result = ObjectRealloc(block, nBytes)
        if result is NULL:
            return NoMemoryNoThrow()
        else:
            return result


cdef void *allocator_alloc_raw(TidyAllocator *self, size_t nBytes) noexcept nogil:
    return allocator_realloc_raw(self, NULL, nBytes)


cdef void *allocator_alloc_gil(TidyAllocator *self, size_t nBytes) noexcept nogil:
    return allocator_realloc_gil(self, NULL, nBytes)


cdef void allocator_free_raw(TidyAllocator *self, void *block) noexcept nogil:
    allocator_realloc_raw(self, block, 0)


cdef void allocator_free_gil(TidyAllocator *self, void *block) noexcept nogil:
    allocator_realloc_gil(self, block, 0)


cdef void allocator_panic(TidyAllocator *self, ctmbstr msg) noexcept nogil:
    with gil:
        raise SystemError(unicode(msg, 'UTF-8', 'replace'))


cdef TidyAllocatorVtbl allocator_raw_vtbl = TidyAllocatorVtbl(
    allocator_alloc_raw,
    allocator_realloc_raw,
    allocator_free_raw,
    allocator_panic,
)

cdef TidyAllocatorVtbl allocator_gil_vtbl = TidyAllocatorVtbl(
    allocator_alloc_gil,
    allocator_realloc_gil,
    allocator_free_gil,
    allocator_panic,
)

cdef TidyAllocator allocator_raw = TidyAllocator(
    &allocator_raw_vtbl,
)

cdef TidyAllocator allocator_gil = TidyAllocator(
    &allocator_gil_vtbl,
)
