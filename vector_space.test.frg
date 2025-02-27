#lang forge

open "vector_space.frg"

------------------------------------------------------------------------



test suite for wellformed {
    // POSITIVE TEST CASES
    example wellformedVectorSpace is { wellformed } for {
        VectorSpace = `VS

        Triple = `zero

        #Int = 4

        `VS.Group = `zero
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = 1
        
        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
    } 

    example validWellformedVectorSpace is { wellformed } for {
        VectorSpace = `VS

        Triple = `v1 + `v2 + `zero

        #Int = 4

        `VS.Group = `v1 + `v2 + `zero
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = 1

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

        #Int = 6

        `VS.Group = `v1 + `zero
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = 1

        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v1.x = 1
        `v1.y = 2
        `v1.z = -9 //invalid number
    } 

    example missingAddIdentity is { not wellformed } for {
        VectorSpace = `VS
        Triple = `v1 + `zero
        
        #Int = 4

        `VS.Group = `v1 // Missing zero vector
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = 1
    } 
}


// TEST VECTOR SPACE AXIOMS
test suite for vector_space_axioms {
    example testAdditiveIdentity is { additiveIdentityAxiom } for {
        VectorSpace = `VS
        Triple = `v1 + `zero

        #Int = 4

        `VS.Group = `v1 + `zero
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = 1

        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v1.x = 2
        `v1.y = 1
        `v1.z = 2
    } 

    example testMultiplicativeIdentity is { multiplicativeIdentityAxiom } for {
        VectorSpace = `VS
        Triple = `v1 + `zero

        #Int = 4
 
        `VS.Group = `v1 + `zero
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = 1
        `zero.x = 0
        `zero.y = 0
        `zero.z = 0

        `v1.x = 2
        `v1.y = 1
        `v1.z = 2
    } 

    example testAdditiveCommutativity is { additiveInverseAxiom and commutativity } for {
        VectorSpace = `VS
        Triple = `v1 + `v2 + `zero

        #Int = 4

        `VS.Group = `v1 + `v2 + `zero
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = 1

        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v1.x = 1
        `v1.y = 1
        `v1.z = 1
        `v2.x = -1
        `v2.y = -1
        `v2.z = -1
    } 

    example testMultiplicativeAssociativity is { associativityMultiplication } for {
        VectorSpace = `VS
        Triple = `v1 + `v2 + `v3 + `zero

        #Int = 4

        `VS.Group = `v1 + `v2 + `v3 + `zero
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = 1

        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v1.x = 2
        `v1.y = 0
        `v1.z = 1
        `v2.x = 1
        `v2.y = 2
        `v2.z = 2
        `v3.x = 1
        `v3.y = 1
        `v3.z = 2
    } 
    example testDistributivity is { distributivity } for {
        VectorSpace = `VS
        Triple = `v1 + `v2 + `v3 + `zero

        #Int = 4

        `VS.Group = `v1 + `v2 + `v3 + `zero
        `VS.AddIdentity = `zero
        `VS.MultiplicativeIdentity = 1

        `zero.x = 0
        `zero.y = 0
        `zero.z = 0
        `v1.x = 2
        `v1.y = 2
        `v1.z = 1
        `v2.x = 1
        `v2.y = 2
        `v2.z = 0
        `v3.x = 1
        `v3.y = 1
        `v3.z = 2
    } 
}

assert wellformed is sat for exactly 1 VectorSpace, exactly 3 Triple, exactly 4 Int

assert {some v: VectorSpace, a, b, c: Triple | addTriple[a, b, c]} is sat
