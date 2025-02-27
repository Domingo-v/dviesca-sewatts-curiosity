#lang forge

// // abstract sig __ {
// //  
// //     
// // }
// //maybe want some abstract sigs

// sig X{
//     x : one Int
// }

// sig Y{
//     y: one Int
// }

// sig Z{
//     z: one Int
// }


// //don't want to use this want combinations of singletons instead
// sig Vector{
//     //define vector - define this with lists somehow, list of vectors in n dimensions - can't be a set bc can have repeating values

//     //functions on vectors - make this bit-wise (we can define this on our own?):
//     //missmatched lengths - consider

//     //vector.length - check to that length
    
//     length : one Int,
//     value: pfunc  Int -> Int // Mapping indices to values  (should only map indices to a number - the number at that indice)
//     // addBitwise: pfunc Vector -> Vector -> Vector,
//     // subtractBitwise: pfunc Vector -> Vector -> Vector,
//     // multiplyBitwise: pfunc Vector -> Vector -> Vector
// }

// sig VectorSpace {
//     //contains vectors
//     Group: set Vector, //need some set of vectors
//     AddIdentity: one Vector, //can think of this as vector 0
//     //AddInverse: pfunc Vector -> Vector, //Maps each vector to its additive inverse
//     MultiplicativeIdentity: one Vector //can think of this as vector 1/scalar identity
// }

// //how do you constrain these functions - addBitwise, subtractBitwise, and multiplyBitwise to do what we want - add/subtract/multiply bitwise
//     //-use indsOf to get indices and add

// //should specify in some predicate what space we're in and the vector set should be as long as the space that we are in - so for R2 there are only two integers in a vector
//     //set the dimension

// //specifying length
// pred specifyLength {
//     all v: Vector | 
//         v.length = 3 //vectors are singletons of `int x `int` x `int -  x, y, z integers instead of vectors
// }

// pred wellformed {
//     // Every vector must have values defined for each index from 0 to length - 1
//     // all s: VectorSpace, v: Vector, idx : Int | 
//     //     (v.value[idx] != (none))  => ((idx >= 0) and (idx < v.length))

//     // all s: VectorSpace, v: Vector, idx : Int | 
//     //     (v in s.Group) =>  lastIdxOf[v.value, seqLast[v.value]] = v.length //checks length against  
        
    
//     //TODO:
//     //make vectors be the right size - give some example size for what space we are in
//     //make vectors map correct indices to a number - the number at that indice
//     //make the vector space only consist of vectors of the right size
//     //make sure add and multiply do what we want (?)

//     //DEFINE LENGTH OF VECTORS IN VECTOR SPACE SOMEWHERE

//     // all s: VectorSpace, v: Vector |
//     //     (v in s.Group) => (v.length = s.AddIdentity.length)  // All vectors must have the same length as zero vector

//     // // Every vector in the vector space must have a properly defined length
//     // all s: VectorSpace, v: Vector |
//     //     (v in s.Group) => (v.length > 0)  // Enforce positive lengths

//     // // The additive identity vector must be in the vector space
//     // all s: VectorSpace | s.AddIdentity in s.Group

//     // // The multiplicative identity vector must also be in the vector space
//     // all s: VectorSpace | s.MultiplicativeIdentity in s.Group

//     // // Closure under bitwise addition and multiplication
//     // all s: VectorSpace, v1, v2, result: Vector |
//     //     ((v1 in s.Group and v2 in s.Group) and addBitwise[v1, v2, result]) => (result in s.Group)

//     // all s: VectorSpace, v1, v2, result: Vector |
//     //     ((v1 in s.Group and v2 in s.Group) and multiplyBitwise[v1, v2, result]) => (result in s.Group)

// }

// // assumes that wellformed is run and thus v1 and v2 are in a vectorspace and thus equal len
// // Define bitwise addition for vectors
// pred addBitwise(v1, v2, result: Vector) {
//     all i: Int |
//         (i >= 0 and i < v1.length) =>
//         result.value[i] = add[v1.value[i], v2.value[i]]
// }

// // Define bitwise multiplication for vectors
// pred multiplyBitwise(v1, v2, result: Vector) {
//     all i: Int |
//         (i >= 0 and i < v1.length) =>
//         result.value[i] = multiply[v1.value[i], v2.value[i]]
// }

// // u + v = v + u
// pred communicativity{
//     //Change it to be value comparison
//     all s: VectorSpace, v1, v2, result1, result2: Vector | 
//             // (i >= 0) and (i <= v1.length)
//             // (v1 in s.Group) and (v2 in s.Group)
//             // addBitwise[v1, v2] = addBitwise[v2, v1]
//             // add[v1.value[i],v2.value[i]] = add[v2.value[i],v1.value[i]]
//             ((v1 in s.Group) and (v2 in s.Group)) =>
//                 ((addBitwise[v1, v2, result1]) and (addBitwise[v2, v1, result2]) and (result1 = result2))
// }

// // (u + v )+ w = u + (v + w)
// pred associativity{
//     all s: VectorSpace, v1, v2, v3 , v1pv2, v2pv3, result1, result2: Vector |
//             // (i >= 0) and (i <= v1.length)
//             // (v1 in s.Group) and (v2 in s.Group) and (v3 in s.Group)
//             // // addBitwise[addBitwise[v1, v2], v3] = addBitwise[v1, addBitwise[v2, v3]]
//             // add[add[v1.value[i], v2.value[i]], v3.value[i]] = add[v1.value[i], add[v2.value[i], v3.value[i]]]
//             ((v1 in s.Group) and (v2 in s.Group)) and (v3 in s.Group) =>
//                 (addBitwise[v1, v2, v1pv2] and addBitwise[v1pv2, v3, result1] and
//                 addBitwise[v2, v3, v2pv3] and addBitwise[v1, v2pv3, result2] and
//                 result1 = result2)
// }


// //value comparisons
// // there is some value for which a + v0 = a
// pred additiveIdentity{
//     all s: VectorSpace |
//         all v, result : Vector |
//             // (i >= 0) and (i <= v.length)  
//             // (v in s.Group)
//             // add[s.AddIdentity.value[i], v.value[i]] = v.value[i]
//             (v in s.Group) =>
//                 (addBitwise[v, s.AddIdentity, result] and result = v)
// }

// // there is some value vi such that any a - vi = v0 (identity)
// pred additiveInverse{
//     all s: VectorSpace, v, result: Vector |
//             // (v in s.Group) 
//             some v_inv : Vector |
//                 ((v in s.Group) and (v_inv in s.Group)) and //does it have to be implies?
//                 (addBitwise[v, v_inv, s.AddIdentity])
// }

// // there is some v1 such that a * v1 = a
// pred multiplicativeIdentity{
//     all s: VectorSpace, v, result : Vector |
//             // (i >= 0) and (i <= v.length)
//             // (v in s.Group)
//             // multiply[s.MultiplicativeIdentity[i], v.value[i]] = v.value[i]
//             (v in s.Group) =>
//                 (multiplyBitwise[v, s.MultiplicativeIdentity, result] and result = v)
// }


// pred distributiveProperties{
//     // all s: VectorSpace, v1, v2: Vector, scalar, i: Int |
//     //     (i >= 0) and (i <= v1.length)
//     //     (v1 in s.Group) and (v2 in s.Group)
//     //     multiply[scalar, add[v1.value[i], v2.value[i]]] = 
//     //     add[multiply[scalar, v1.value[i]], multiply[scalar, v2.value[i]]]

//     all s: VectorSpace, v1, v2, scalar, temp, result1, result2, result3: Vector |
//         ((v1 in s.Group) and (v2 in s.Group)) =>
//             (addBitwise[v1, v2, temp] and multiplyBitwise[scalar, temp, result1] and
//             multiplyBitwise[scalar, v1, result2] and multiplyBitwise[scalar, v2, result3] and
//             addBitwise[result2, result3, result1])
// }


// //check the adds, subtracts, and multiply






// //Then do a specifiic proof, Prove that −(−𝑣) = 𝑣 for every 𝑣 ∈ 𝑉.
//     //prove the contrapositive - unsatisfiable (bc gives us examples or unsatisfiable)

// //or maybe a proof by induction


// run {
//     wellformed  
//     communicativity
//     associativity
//     additiveIdentity
//     additiveInverse
//     multiplicativeIdentity
//     distributiveProperties
//     specifyLength
// }  for exactly 1 VectorSpace, 2 Vector








































// #lang forge

// technically still a vector sig but dont understand how to get around this fully 
sig Triple {
    x: one Int,
    y: one Int,
    z: one Int
}

// vectorspace contains triples and the identities
sig VectorSpace {
    Group: set Triple,            
    AddIdentity: one Triple,      
    MultiplicativeIdentity: one Int
}


//WE NEED TO ADD THEM TO VECTOR SPACE, rn vector space is empty - we're not even using vector space

//we need to limit the integers to go from 0 to 4 (but we want more values this is bad/too little - how do we expand bid width) DONE

// Limit x, y, z values to be in {0,1,2,3,4}
pred wellformed {
    all t: Triple | t.x >= -2 and t.x <= 2 and
                      t.y >= -2 and t.y <= 2 and
                      t.z >= -2 and t.z <= 2

    // Group must contain at least one element
    // some VectorSpace.Group

    all t: Triple |
        some s: VectorSpace |
            t in s.Group
    
    // Additive identity must be in the group
    // VectorSpace.AddIdentity in VectorSpace.Group
    
    // Multiplicative identity must be in the group
    // VectorSpace.MultiplicativeIdentity in VectorSpace.Group

    // Closure under addition
    // all a, b: Triple | (a in VectorSpace.Group and b in VectorSpace.Group) =>
    //     (some c: Triple | addTriple[a, b, c] and c in VectorSpace.Group)

    // Closure under multiplication
    // all a, b: Triple | (a in VectorSpace.Group and b in VectorSpace.Group) =>
    //     (some c: Triple | multiplyTriple[a, b, c] and c in VectorSpace.Group)
}


// bitwise addition
pred addTriple(a, b, c: Triple) {
    c.x = add[a.x, b.x] and
    c.y = add[a.y, b.y] and
    c.z = add[a.z, b.z]
}

// bitwise mult
//WAIT MULTIPLY DOESNT EXIST IN VECTOR SPACES IT IS SCALAR MULTIPLICATION
pred multiplyTriple(b: Int, a, c: Triple) {
    c.x = multiply[a.x, b] and
    c.y = multiply[a.y, b] and
    c.z = multiply[a.z, b]
}


// additive identity where vector stays the same
pred additiveIdentityAxiom {
    all v: Triple | 
        some s: VectorSpace |
            // (v in s.Group) => (addTriple[v, s.AddIdentity, v])
            (addTriple[v, s.AddIdentity, v])
}

// every vector has an additive inverse
pred additiveInverseAxiom {
    all v: Triple | 
        some s: VectorSpace |
            // (v in s.Group) => (some inv: Triple | addTriple[v, inv, s.AddIdentity])
            (some inv: Triple | addTriple[v, inv, s.AddIdentity])
}

//  multiplicative identity where vector stays the same
//multiplicative identity is wrong WAS WRONG 
pred multiplicativeIdentityAxiom {
    all v: Triple | 
        some s: VectorSpace |
            // (v in s.Group) => (multiplyTriple[v, s.MultiplicativeIdentity, v])
            (multiplyTriple[s.MultiplicativeIdentity, v, v])
}

//communitativy, associativity, distributive props

//𝑢 + 𝑣 = 𝑣 + 𝑢 
pred commutativity {
    all a, b, c: Triple |
        // some s: VectorSpace | 
        // 
            // (a in s.Group and b in s.Group) => {
            some c1, c2, d1, d2: Triple |
                ((addTriple[a, b, c1] and addTriple[b, a, c2]) => (c1 = c2))
    // }
}


//(𝑢 + 𝑣) + 𝑤 = 𝑢 + (𝑣 + 𝑤) 
//and (𝑎𝑏)𝑣 = 𝑎(𝑏𝑣) for all 𝑢, 𝑣, 𝑤 ∈ 𝑉 and for all 𝑎, 𝑏 ∈ F - a and b are fields so they are just one value (they are just an int multiplied - they are scalars)


pred associativityAddition {
    all a, b, c, r1, r2, s1, s2: Triple |
        // (a in s.Group and b in s.Group and c in s.Group) =>
        ((addTriple[a, b, r1] and addTriple[r1, c, r2] and 
         addTriple[b, c, s1] and addTriple[a, s1, s2]) => (r2 = s2))
}


//(𝑎𝑏)𝑣 = 𝑎(𝑏𝑣)
//a, b scalars
//v vector
pred associativityMultiplication {
    all a, b, t1: Int, v, t2, r1, r2: Triple |
        (t1 = multiply[a, b] and //t1 is integer
        multiplyTriple[t1, v, r1] and
        multiplyTriple[b, v, t2] and
        multiplyTriple[a, t2, r2]) => (r1 = r2)

}

//𝑎(𝑢 + 𝑣) = 𝑎𝑢 + 𝑎𝑣 and (𝑎 + 𝑏)𝑣 = 𝑎𝑣 + 𝑏v
//a, b are scalars
//u, v are vectors

pred distributivity {
  all a, b: Int, v, u, t1, t2, t3, r1, r2: Triple |
    (addTriple[u, v, t1] and
    multiplyTriple[a, t1, r1] and
    multiplyTriple[a, u, t2] and
    multiplyTriple[a, v, t3] and
    addTriple[t2, t3, r2]) => (r1 = r2)
}



option no_overflow true
run {
    wellformed and
    additiveIdentityAxiom and 
    additiveInverseAxiom and 
    multiplicativeIdentityAxiom and
    commutativity and
    associativityAddition and
    associativityMultiplication and
    distributivity
} for exactly 1 VectorSpace, exactly 3 Triple, exactly 4 Int


// run { } 
//   for 10 Int // [-512,511]
//   for {
//     additiveIdentityAxiom and 
//     additiveInverseAxiom and 
//     multiplicativeIdentityAxiom
// } for exactly 1 VectorSpace, exactly 5 Triple


// run {
//     additiveIdentityAxiom and 
//     additiveInverseAxiom and 
//     multiplicativeIdentityAxiom
// } for exactly 1 VectorSpace, exactly 5 Triple, 10 Int 
//   for {
//     all t: Triple | t.x >= 0 and t.x <= 100 and
//                       t.y >= 0 and t.y <= 100 and
//                       t.z >= 0 and t.z <= 100
// }

