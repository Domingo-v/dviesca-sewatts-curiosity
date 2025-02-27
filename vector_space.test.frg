#lang forge

open "vector_space.frg"

------------------------------------------------------------------------

// Remember that this assignment has Toadus Ponens support!
// Check out https://docs.google.com/document/d/1zdv6uF7jdC8CR-d73AojsH68jaLmNG3MwlcZ9R2lWpc/edit?usp=sharing for more information.

// test suite for wellformed {
//     // POSITIVE TEST CASES
//     // Example of a valid wellformed vector space
//     example validWellformedVectorSpace is { wellformed } for {
//         VectorSpace = `VS
//         Vector = `v1 + `v2 + `zero
//         Int = 0 + 1 + 2 //is this right?
//         `VS.Group = `v1 + `v2 + `zero
//         `VS.AddIdentity = `zero
//         `zero.length = 3
//         `v1.length = 3
//         `v2.length = 3
//         `zero.value = 0->0 + 1->0 + 2->0
//         `v1.value = 0->1 + 1->2 + 2->3
//         `v2.value = 0->3 + 1->2 + 2->1
//     }
    
//     // NEGATIVE TEST CASES
//     // Vector has incorrect length
//     example invalidVectorLength is { not wellformed } for {
//         VectorSpace = `VS
//         Vector = `v1 + `zero
//         Int = 0 + 1 + 2 + 3
//         `VS.Group = `v1 + `zero
//         `VS.AddIdentity = `zero
//         `zero.length = 3
//         `v1.length = 4 // Invalid length
//         `zero.value = 0->0 + 1->0 + 2->0
//         `v1.value = 0->1 + 1->2 + 2->3 + 3->4
//     }

//     // Vector missing an index mapping
//     example missingIndexMapping is { not wellformed } for {
//         VectorSpace = `VS
//         Vector = `v1 + `zero
//         Int = 0 + 1 + 2
//         `VS.Group = `v1 + `zero
//         `VS.AddIdentity = `zero
//         `zero.length = 3
//         `v1.length = 3
//         `zero.value = 0->0 + 1->0 + 2->0
//         `v1.value = 0->1 + 1->2  // Missing index 2`
//     }

//     // Additive identity is missing from the group
//     example missingAddIdentity is { not wellformed } for {
//         VectorSpace = `VS
//         Vector = `v1
//         Int = 0 + 1 + 2
//         `VS.Group = `v1  // Missing `zero`
//         `VS.AddIdentity = `zero
//         `zero.length = 3
//         `v1.length = 3
//         `zero.value = 0->0 + 1->0 + 2->0
//         `v1.value = 0->1 + 1->2 + 2->3
//     }
// }

//TEST OTHER PREDICATES
//ADD //ASSERT STATEMENTS

// TEST WELLFORMED PROPERTY
test suite for wellformed {
    // POSITIVE TEST CASES
    example wellformedVectorSpace is { wellformed } for {
        VectorSpace = `VS

        Triple = `zero

        Int = 0 + 1 + 2 + 3 + 4 + -1 + -2 + -3 + -4

        `VS.Group = {`zero}
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = 1
        
        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
    } 

    example validWellformedVectorSpace is { wellformed } for {
        VectorSpace = `VS

        Triple = `v1 + `v2 + `zero

        Int = 0 + 1 + 2 + 3 + 4 + -1 + -2 + -3 + -4

        `VS.Group = `v1 + `v2 + `zero
        `VS.AddIdentity = `zero

        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v1.x = 1
        `v1.y = 2
        `v1.z = 2
        `v2.x = 2
        `v2.y = 2
        `v2.z = 1
    } 

    // NEGATIVE TEST CASES
    example invalidVectorLength is { not wellformed } for {
        VectorSpace = `VS
        Triple = `v1 + `zero
        Int = 0 + 1 + 2 + 3 + 4 + -1 + -2 + -3 + -4
        `VS.Group = `v1 + `zero
        `VS.AddIdentity = `zero
        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v1.x = 1
        `v1.y = 2
        // Missing `v1.z`, which is invalid
    } 

    example missingAddIdentity is { not wellformed } for {
        VectorSpace = `VS
        Triple = `v1
        Int = 0 + 1 + 2 + 3 + 4 + -1 + -2 + -3 + -4
        `VS.Group = `v1 // Missing zero vector
        `VS.AddIdentity = `zero
        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v1.x = 1
        `v1.y = 2
        `v1.z = 3
    } 
}

// TEST VECTOR SPACE AXIOMS
test suite for vector_space_axioms {
    example testAdditiveIdentity is { additiveIdentityAxiom } for {
        VectorSpace = `VS
        Triple = `v1 + `zero
        Int = 0 + 1 + 2 + 3 + 4 + -1 + -2 + -3 + -4
        `VS.Group = `v1 + `zero
        `VS.AddIdentity = `zero
        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v1.x = 2
        `v1.y = 3
        `v1.z = 4
    } 

    example testMultiplicativeIdentity is { multiplicativeIdentityAxiom } for {
        VectorSpace = `VS
        Triple = `v1 + `zero + `v2
        Int = 0 + 1 + 2 + 3 + 4 + -1 + -2 + -3 + -4
        `VS.Group = `v1 + `zero + `v2
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = `v2
        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v2.x = 1
        `v2.y = 1
        `v2.z = 1
        `v1.x = 2
        `v1.y = 3
        `v1.z = 4
    } 

    example testAdditiveCommutativity is { additiveInverseAxiom and commutativity } for {
        VectorSpace = `VS
        Triple = `v1 + `v2 + `zero
        Int = 0 + 1 + 2 + 3 + 4 + -1 + -2 + -3 + -4
        `VS.Group = `v1 + `v2 + `zero
        `VS.AddIdentity = `zero
        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v1.x = 2
        `v1.y = 1
        `v1.z = 3
        `v2.x = 1
        `v2.y = 3
        `v2.z = 2
    } 

    example testMultiplicativeAssociativity is { associativityMultiplication } for {
        VectorSpace = `VS
        Triple = `v1 + `v2 + `v3 + `zero + `vone
        Int = 0 + 1 + 2 + 3 + 4 + -1 + -2 + -3 + -4
        `VS.Group = `v1 + `v2 + `v3 + `zero + `vone
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = `vone
        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `vone.x = 1
        `vone.y = 1
        `vone.z = 1
        `v1.x = 2
        `v1.y = 3
        `v1.z = 1
        `v2.x = 1
        `v2.y = 2
        `v2.z = 3
        `v3.x = 3
        `v3.y = 1
        `v3.z = 2
    } 
    example testDistributivity is { distributivity } for {
        VectorSpace = `VS
        Triple = `v1 + `v2 + `v3 + `zero + `vone
        Int = 0 + 1 + 2 + 3 + 4 + -1 + -2 + -3 + -4
        `VS.Group = `v1 + `v2 + `v3 + `zero + `vone
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = `vone
        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `vone.x = 1
        `vone.y = 1
        `vone.z = 1
        `v1.x = 2
        `v1.y = 3
        `v1.z = 1
        `v2.x = 1
        `v2.y = 2
        `v2.z = 3
        `v3.x = 3
        `v3.y = 1
        `v3.z = 2
    } 
}

