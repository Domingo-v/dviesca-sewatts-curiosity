# dviesca-sewatts-curiosity

Project Overview:

For our project we worked to model a valid vector space. Basically, we wanted Forge to create valid vector spaces for us given the axioms and constraints that are necessary
for valid vector spaces. Specifically, vector spaces need an additive identity (a conception of the zero vector - adding this to any original vector gives you the original vector),
a multiplicative scalar (a conception of one - multiplying this b) and every vector in the space must have a corresponding additive inverse vector that when summed with the
original vector gives you the additive identity (again basically the zero vector). Addition in vector spaces works as bitwise addition and multiplication works  as a scalar times
a vector and both of these operations are closed - combining vectors in this manner gives you a result that stays in the vector space. Additionally, vector spaces have some axioms that
must be true, namely communitativity, associativity, and distributivity. All of these rules are constraints that limit what a valid vector space is and so we defined
these constraints so that Forge would hand us back valid vector spaces. We did this specifically in R^3 so with vectors of length 3 and kept the bit width to 4 so the values range
only from {-2, -1, 0, 1, 2} to keep it simple.


Model Design and Visualization:

The model is again a valid vector space in R^3 with integer components restricted to the set {−2,−1,0,1,2}. We represented vectors as sig Triples which is a 3D vector with
integer components (x, y, z). The vector space itself is also a sig that contains a set of vectors (Group), an additive identity (AddIdentity), and a multiplicative scalar identity (MultiplicativeIdentity). To enforce the mathematical properties of a vector space, we defined a set of constraints ensuring closeure under addition and multiplication as
addition (addTriple) follows bitwise vector addition and multiplication (multiplyTriple) represents scalar multiplication. Then we also made sure the additive identity and the
multiplicative identiy existed in the vector space and that for every vector there was an additive inverse. Then we checked commutativity, which means for all vectors u and v,
(u+v) should equal (v+u). We checked associativity of addition which means for all vectors u, v, and w, ((u+v)+w) should equal (u+(v+w)). We checked associativity of scalar
multiplication which means for all vectors v and all scalars in the real a and b, ((ab)v) should equal (a(bv)). Finally we checked distributivity which checks that for all
scalars a and vectors u and v, a(u+v)=au+av and for all scalars a and b and all vectors v, (a+b)v=av+bv.

To make the vector space correctly, we included the wellformed predicate, which enforces the domain restrictions for vector components and guarantees that all vectors belong
to a vector space.

Our run statement is below:
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
And it ensures that we are testing a vector space with one vector space, three Triples (which is necessary for a valid vector space), and bit width of 4 for integers.

We used Sterling's default visualizer to inspect the vector spaces. An instance produced by the model displays the VectorSpace node that contains the group of vectors,
the additive identiy, and a multiplicative identity. The edges between elements should membership in the group. This visualization helps verify that our constraints
correctly define a vector space.



Signatures and Predicates: At a high level, what do each of your sigs and preds represent in the context of the model? Justify the purpose for their existence and how they fit together.
-  In the context of our model the main predicates delimit the definition of  vectorspace via constraints. For example a vector space satisfies additive identity if the vector space has one value in which any vector v plus that identity value results in v. This follows for all of the definitions of a vector space: Commutativity, Associativity, additive Identity, multiplicative identity, additive inverse, distributivity. All of these definitions have their own corresponding predicates that constrains what a vector and vector space can be. We additionally added some modeling specific predicates like wellformed and add triple. Wellformed checks that values within vectors/triples are within a set range so that bit width does not cause unexpected consequences in addition or multiplication. addTriple and multiplyTriple are functional predicates  which are meant to replicate the functionality of addition and multiplication for our specific implementation of triples such that we can use them in the aforementioned predicate constraints.

Testing: What tests did you write to test your model itself? What tests did you write to verify properties about your domain area? Feel free to give a high-level overview of this.
- Testing took us a while to figure out not necessarily because we encountered many failed tests that showed mistakes in our implementation, but because we struggled to figure out how to our structures correctly in relational forge and not froglet. As we worked we used the visualizer and tables to get a high level understanding of what was going on. For example with the visualizer we quickly realized that the length parameter (when we were using it) was not accounting for the last element, or that bitwith was to small to account for vector multiplication and so on. Our main test suite is comprised primarily of positive and negative example cases in which we test each predicate individually and with relevant other predicates. Because our model parallels the constraint style definition of vector spaces when these all pass, save for bugs like bit width and such, the testing is very straightforward. We also have a few assert statements that check the satisfiability of our predicates, and the run commands that run all of the predicates together show that our implementation works well within our scope. A scope issue we have is that because of bit width limitations wellformed has to be modified to test for larger test cases, but we account for this by altering #int.

Documentation: Make sure your model and test files are well-documented. This will help in understanding the structure and logic of your project.

- Done