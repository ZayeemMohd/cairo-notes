fn foo() -> u32 {
    5
    // the statement is implecitly returned if we didn't add return keyword at the begining and semicolon at the end
}

fn bar() -> u32 {
    foo()
    // it will return 5 form foo which is u32
}

fn baz() -> u32 {
    return 10;
    // we are explicitly returning the 10 with the use of return keyword and semicolon
}

fn double(x: u32) -> u32 {
    x * 2
}

#[cfg(test)]
mod test {

    // since the function we defined are out of the scope of this "test" module. to bring it in the scope and to use their refrence in the test module we need use the "use" statement
    use super::*;

    #[test]
    fn test_foo() {
        //  we are adding _u32 to compare with the type explicitly, otherwise it implicitly compares it
        assert!(foo() == 5_u32)
    }

    #[test]
    fn test_bar() {
        assert!(bar() == 5);
    }

    #[test]
    fn test_baz() {
        assert!(baz() == 10_u32);
    }

    #[test]
    fn test_double(){
        assert!(double(2) == 4);
    }
}