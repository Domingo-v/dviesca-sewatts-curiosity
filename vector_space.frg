#lang forge

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


// Limit x, y, z values to be in {-2, -1, 0,1,2}
pred wellformed {
    all t: Triple | t.x >= -2 and t.x <= 2 and
                      t.y >= -2 and t.y <= 2 and
                      t.z >= -2 and t.z <= 2

    // Group must contain at least one element
    // some VectorSpace.Group

    all t: Triple |
        some s: VectorSpace |
            t in s.Group
    
}


// bitwise addition
pred addTriple(a, b, c: Triple) {
    c.x = add[a.x, b.x] and
    c.y = add[a.y, b.y] and
    c.z = add[a.z, b.z]
}

//MULTIPLY DOESNT EXIST IN VECTOR SPACES IT IS SCALAR MULTIPLICATION
pred multiplyTriple(b: Int, a, c: Triple) {
    c.x = multiply[a.x, b] and
    c.y = multiply[a.y, b] and
    c.z = multiply[a.z, b]
}


// additive identity where vector stays the same
pred additiveIdentityAxiom {
    all v: Triple | 
        some s: VectorSpace |
            (addTriple[v, s.AddIdentity, v])
}

// every vector has an additive inverse
pred additiveInverseAxiom {
    all v: Triple | 
        some s: VectorSpace |
            (some inv: Triple | addTriple[v, inv, s.AddIdentity])
}

//  multiplicative identity where vector stays the same
pred multiplicativeIdentityAxiom {
    all v: Triple | 
        some s: VectorSpace |
            (multiplyTriple[s.MultiplicativeIdentity, v, v])
}

//communitativy, associativity, distributive props

//𝑢 + 𝑣 = 𝑣 + 𝑢 
pred commutativity {
    all a, b, c: Triple |
            some c1, c2, d1, d2: Triple |
                ((addTriple[a, b, c1] and addTriple[b, a, c2]) => (c1 = c2))
}


//(𝑢 + 𝑣) + 𝑤 = 𝑢 + (𝑣 + 𝑤) 
pred associativityAddition {
    all a, b, c, r1, r2, s1, s2: Triple |
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
