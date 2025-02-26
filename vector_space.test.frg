#lang forge

open "vector_space.frg"

------------------------------------------------------------------------

// Remember that this assignment has Toadus Ponens support!
// Check out https://docs.google.com/document/d/1zdv6uF7jdC8CR-d73AojsH68jaLmNG3MwlcZ9R2lWpc/edit?usp=sharing for more information.

test suite for wellformed {
    // POSITIVE TEST CASES
    // Example of a valid wellformed vector space
    example validWellformedVectorSpace is { wellformed } for {
        VectorSpace = `VS
        Vector = `v1 + `v2 + `zero
        Int = 0 + 1 + 2 //is this right?
        `VS.Group = `v1 + `v2 + `zero
        `VS.AddIdentity = `zero
        `zero.length = 3
        `v1.length = 3
        `v2.length = 3
        `zero.value = 0->0 + 1->0 + 2->0
        `v1.value = 0->1 + 1->2 + 2->3
        `v2.value = 0->3 + 1->2 + 2->1
    }
    
    // NEGATIVE TEST CASES
    // Vector has incorrect length
    example invalidVectorLength is { not wellformed } for {
        VectorSpace = `VS
        Vector = `v1 + `zero
        Int = 0 + 1 + 2 + 3
        `VS.Group = `v1 + `zero
        `VS.AddIdentity = `zero
        `zero.length = 3
        `v1.length = 4 // Invalid length
        `zero.value = 0->0 + 1->0 + 2->0
        `v1.value = 0->1 + 1->2 + 2->3 + 3->4
    }

    // Vector missing an index mapping
    example missingIndexMapping is { not wellformed } for {
        VectorSpace = `VS
        Vector = `v1 + `zero
        Int = 0 + 1 + 2
        `VS.Group = `v1 + `zero
        `VS.AddIdentity = `zero
        `zero.length = 3
        `v1.length = 3
        `zero.value = 0->0 + 1->0 + 2->0
        `v1.value = 0->1 + 1->2  // Missing index 2`
    }

    // Additive identity is missing from the group
    example missingAddIdentity is { not wellformed } for {
        VectorSpace = `VS
        Vector = `v1
        Int = 0 + 1 + 2
        `VS.Group = `v1  // Missing `zero`
        `VS.AddIdentity = `zero
        `zero.length = 3
        `v1.length = 3
        `zero.value = 0->0 + 1->0 + 2->0
        `v1.value = 0->1 + 1->2 + 2->3
    }
}

//TEST OTHER PREDICATES
//ADD ASSERT STATEMENTS
