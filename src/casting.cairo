#[cfg(test)]
mod test {

    #[test]
    fn test_casting_to_bigger_type(){
        let a: u8 = 10;
        // we can typecast variable value form smaller bucket into bigger bucket, in this case form u8 to u16
        assert!(a.try_into().unwrap() == 10_u16)
    }

    #[test]
    fn test_casting_to_smaller_type_that_fits() {
        let a: u16 = 8;
        // here typecasting form larger to smaller works when the value in larger is capable to fit in smaller
        assert!(a.try_into().unwrap() == 8_u8);
    }

    #[test]
    fn test_casting_to_smaller_type_that_overflows_1() {
        let a: u16 = 257;
        // assert!(a.try_into().unwrap() == 257_u8) // error: can't corvert to type _u8
        // we can also check this situatiion like this
        // .try_into() returns enum and it contains two values "is_some" if exists or "is_none" if impossible to do conversion
        let b: Option<u8> = a.try_into();
        assert!(b.is_none());
    }

    #[test]
    fn test_casting_to_smaller_type_that_overflows_2() {
        let a: u16 = 1000;
        let b: Option<u8> = a.try_into();
        // .unwrap_or() is a happy path to handle fail cases gracefully with the alternative value that fits
        let c: u8 = b.unwrap_or(255);
        assert!(c == 255_u8)
    }

    #[test]
    fn type_casting_to_smaller_type_that_overflows_3() {
        let a: u16 = 1000;
        // this is a more consice version of handling fail cases gracefully
        let b: u8 = a.try_into().unwrap_or(255);
        assert!(b == 255_u8);
    }
}