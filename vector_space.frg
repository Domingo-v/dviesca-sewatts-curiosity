#lang forge

// abstract sig __ {
//  
//     
// }
//maybe want some abstract sigs


sig VectorSpace {
    //contains vectors
    Group: set Vector //need some set of vectors
    AddIdentity: one Vector //can think of this as 0
    AddInverse: one Vector
    MultiplicativeIdentity: one Vector
}

sig Vectors{
    //define vector - define this with lists somehow, list of vectors in n dimensions

    //functions on vectors - make this bit-wise (we can define this on our own?):
    //missmatched lengths - consider
    addBitwise: pfunc Vector -> Vector -> Vector
    subtractBitwise: pfunc Vector -> Vector -> Vector
    multiplyBitwise: pfunc Vector -> Vector -> Vector
}

pred init {
    //init values

}

pred communicativity{
    all v : VectorSpace |
    all a : Vector |

}

pred associativity{

}

pred additiveIdentity{
    //use our function of addition instead (add bit-wise)
    all s: VectorSpace |
        all vector in s.Group | 
            s.addBitwise[s.AddIdentity, vector] = vector
            // s.addIdentity + vector = vector
            //
}

pred additiveInverse{
    all s: VectorSpace |
        some v1, v2 in s.Group |
         (v1 != v2) and (v2 != v1) => s.addBitwise[v1,v2] = s.AddIdentity


}

pred multiplicativeIdentity{
    //1𝑣 = 𝑣 for all 𝑣 ∈ 𝑉.
    all s: VectorSpace |
        all vector in s.Group |
            s.MultiplyBitwise[s.MultiplicativeIdentity, vector] = vector
}

pred distributiveProperties{
    
}

//check the adds, subtracts, and multiply

//Then do a specifiic proof, Prove that −(−𝑣) = 𝑣 for every 𝑣 ∈ 𝑉.
    //prove the contrapositive - unsatisfiable (bc gives us examples or unsatisfiable)

//or maybe a proof by induction

//run {FamilyFact ownGrandparent} for exactly 4 Person
    //if not sets then could do exact number of vectors, maybe like 10 vectors, and satisfy for 10 vectors - each with say 5 elements
    //and can expand that size later