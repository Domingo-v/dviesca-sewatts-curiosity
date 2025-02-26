#lang forge

// abstract sig __ {
//  
//     
// }
//maybe want some abstract sigs

sig Vector{
    //define vector - define this with lists somehow, list of vectors in n dimensions - can't be a set bc can have repeating values

    //functions on vectors - make this bit-wise (we can define this on our own?):
    //missmatched lengths - consider

    //vector.length - check to that length
    
    length : one Int,
    value: pfunc  Int -> Int // Mapping indices to values  (should only map indices to a number - the number at that indice)
    // addBitwise: pfunc Vector -> Vector -> Vector,
    // subtractBitwise: pfunc Vector -> Vector -> Vector,
    // multiplyBitwise: pfunc Vector -> Vector -> Vector
}

sig VectorSpace {
    //contains vectors
    Group: set Vector, //need some set of vectors
    AddIdentity: one Vector, //can think of this as vector 0
    //AddInverse: pfunc Vector -> Vector, //Maps each vector to its additive inverse
    MultiplicativeIdentity: one Vector //can think of this as vector 1/scalar identity
}

//how do you constrain these functions - addBitwise, subtractBitwise, and multiplyBitwise to do what we want - add/subtract/multiply bitwise
    //-use indsOf to get indices and add

//should specify in some predicate what space we're in and the vector set should be as long as the space that we are in - so for R2 there are only two integers in a vector
    //set the dimension

//specifying length
pred specifyLength {
    all v: Vector | 
        v.length = 5
}

pred wellformed {
    all s: VectorSpace, v: Vector | 
        (v in s.Group) =>  lastIdxOf[v, seqLast[v]] = v.length //checks length against 

    
    //TODO:
    //make vectors be the right size - give some example size for what space we are in
    //make vectors map correct indices to a number - the number at that indice
    //make the vector space only consist of vectors of the right size
    //make sure add and multiply do what we want (?)

    //DEFINE LENGTH OF VECTORS IN VECTOR SPACE SOMEWHERE

    all s: VectorSpace, v: Vector |
        (v in s.Group) => (v.length = s.AddIdentity.length)  // All vectors must have the same length as zero vector

    // Every vector must have values defined for each index from 0 to length - 1
    all v: Vector, i: Int |
        (i >= 0 and i < v.length) => (i in v.value) // Ensures indices map to some value

    // Every vector in the vector space must have a properly defined length
    all s: VectorSpace, v: Vector |
        (v in s.Group) => (v.length > 0)  // Enforce positive lengths

    // The additive identity vector must be in the vector space
    all s: VectorSpace | s.AddIdentity in s.Group

    // The multiplicative identity vector must also be in the vector space
    all s: VectorSpace | s.MultiplicativeIdentity in s.Group

    // Closure under bitwise addition and multiplication
    all s: VectorSpace, v1, v2, result: Vector |
        ((v1 in s.Group and v2 in s.Group) and addBitwise[v1, v2, result]) => (result in s.Group)

    all s: VectorSpace, v1, v2, result: Vector |
        ((v1 in s.Group and v2 in s.Group) and multiplyBitwise[v1, v2, result]) => (result in s.Group)

}

// assumes that wellformed is run and thus v1 and v2 are in a vectorspace and thus equal len
// Define bitwise addition for vectors
pred addBitwise(v1, v2, result: Vector) {
    all i: Int |
        (i >= 0 and i < v1.length) =>
        result.value[i] = add[v1.value[i], v2.value[i]]
}

// Define bitwise multiplication for vectors
pred multiplyBitwise(v1, v2, result: Vector) {
    all i: Int |
        (i >= 0 and i < v1.length) =>
        result.value[i] = multiply[v1.value[i], v2.value[i]]
}

// u + v = v + u
pred communicativity{
    //Change it to be value comparison
    all s: VectorSpace, v1, v2, result1, result2: Vector | 
            // (i >= 0) and (i <= v1.length)
            // (v1 in s.Group) and (v2 in s.Group)
            // addBitwise[v1, v2] = addBitwise[v2, v1]
            // add[v1.value[i],v2.value[i]] = add[v2.value[i],v1.value[i]]
            ((v1 in s.Group) and (v2 in s.Group)) =>
                (addBitwise[v1, v2, result1] and addBitwise[v2, v1, result2] and result1 = result2)
}

// (u + v )+ w = u + (v + w)
pred associativity{
    all s: VectorSpace, v1, v2, v3 , v1pv2, v2pv3, result1, result2: Vector |
            // (i >= 0) and (i <= v1.length)
            // (v1 in s.Group) and (v2 in s.Group) and (v3 in s.Group)
            // // addBitwise[addBitwise[v1, v2], v3] = addBitwise[v1, addBitwise[v2, v3]]
            // add[add[v1.value[i], v2.value[i]], v3.value[i]] = add[v1.value[i], add[v2.value[i], v3.value[i]]]
            ((v1 in s.Group) and (v2 in s.Group)) and (v3 in s.Group) =>
                (addBitwise[v1, v2, v1pv2] and addBitwise[v1pv2, v3, result1] and
                addBitwise[v2, v3, v2pv3] and addBitwise[v1, v2pv3, result2] and
                result1 = result2)
}


//value comparisons
// there is some value for which a + v0 = a
pred additiveIdentity{
    all s: VectorSpace |
        all v, result : Vector |
            // (i >= 0) and (i <= v.length)  
            // (v in s.Group)
            // add[s.AddIdentity.value[i], v.value[i]] = v.value[i]
            (v in s.Group) =>
                (addBitwise[v, s.AddIdentity, result] and result = v)
}

// there is some value vi such that any a - vi = v0 (identity)
pred additiveInverse{
    all s: VectorSpace, v, result: Vector |
            // (v in s.Group) 
            some v_inv : Vector |
                ((v in s.Group) and (v_inv in s.Group)) and //does it have to be implies?
                (addBitwise[v, v_inv, s.AddIdentity])
}

// there is some v1 such that a * v1 = a
pred multiplicativeIdentity{
    all s: VectorSpace, v, result : Vector |
            // (i >= 0) and (i <= v.length)
            // (v in s.Group)
            // multiply[s.MultiplicativeIdentity[i], v.value[i]] = v.value[i]
            (v in s.Group) =>
                (multiplyBitwise[v, s.MultiplicativeIdentity, result] and result = v)
}


pred distributiveProperties{
    // all s: VectorSpace, v1, v2: Vector, scalar, i: Int |
    //     (i >= 0) and (i <= v1.length)
    //     (v1 in s.Group) and (v2 in s.Group)
    //     multiply[scalar, add[v1.value[i], v2.value[i]]] = 
    //     add[multiply[scalar, v1.value[i]], multiply[scalar, v2.value[i]]]

    all s: VectorSpace, v1, v2, scalar, temp, result1, result2, result3: Vector |
        ((v1 in s.Group) and (v2 in s.Group)) =>
            (addBitwise[v1, v2, temp] and multiplyBitwise[scalar, temp, result1] and
            multiplyBitwise[scalar, v1, result2] and multiplyBitwise[scalar, v2, result3] and
            addBitwise[result2, result3, result1])
}


//check the adds, subtracts, and multiply






//Then do a specifiic proof, Prove that −(−𝑣) = 𝑣 for every 𝑣 ∈ 𝑉.
    //prove the contrapositive - unsatisfiable (bc gives us examples or unsatisfiable)

//or maybe a proof by induction


run {
    wellformed  
    communicativity
    associativity
    additiveIdentity
    additiveInverse
    multiplicativeIdentity
    distributiveProperties
}  for exactly 1 VectorSpace, 2 Vector
