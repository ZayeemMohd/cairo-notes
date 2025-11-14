// Test Driven Development

mod felts; // 1
mod functions; // 2
mod integers; // 3
mod casting; // 4
mod result_and_option; // 5
mod enums; // 6
mod mutable; // 7

//important
// differnt ways to handle ownerships: Snapshots(for readonly), references(return ownership + write(update)), CopyTrait(pass a copy of the struct/value)
mod snapshots; // 8
mod refrences; // 9
mod copy_trait; // 10

mod traits_and_generics; // 11    // factory pattern: struct -> trait -> impl
mod constrains; //  12  you will get compiler issue if you use cairo version < cairo: 2.12.0

mod arrays; // 13