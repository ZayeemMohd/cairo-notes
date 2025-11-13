#[cfg(test)]

mod tests {

    // #[test]
    // fn test_immutability(){
    //     let a: u32 = 1;
    //     // a = 3; // can't mutate in cairo
    // }

    #[test]
    fn test_shadowing() {
        let a: u32 = 34;
        assert!(a == 34_u32);

        // to re-assign any to the existing variable, we need to re-define the variable; we are not modifying variable instead we are creating a new variable with the same name which is shadowing the old one
        let a: u8 = 2;
        assert!(a == 2_u8)
    }

    #[test]
    fn test_mutability() {
        // mutablity is possible with "mut" keyword
        let mut a: u32 = 43;
        a = 34;
        assert!(a == 34_u32);
    }

    #[test]
    fn test_constannts() {
        // use capital letters it is convention, constants are immutable everytime also with "mut" keyword and initializing let and const are mandatory; you can't just define and leave.
        // constants are mostly declared at global scope according to cairo book.
        const A: u32 = 34;
        assert!(A == 34_u32);
    }
}