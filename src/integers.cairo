fn unsigned_integers(){
    let _a: u8 = 255; // max value 2^8 = 255
    let _b: u16 = 65535; // max value 2^16
    let _c: u32 = 4294967295; // max value 2^32
    let _d: u64 = 18446744073709551615; // max value 2^64
    let _e: u128 = 340282366920938463463374607431768211455; // max value 2^128
    let _f: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935; // max value 2^256

    // adding _ before the variable_name stops the error of unused variable

    // we can also define the types at the end of variable initialization with _datatype
    let _g = 255_u8;
    let _h = 65535_u16;
    let _i = 4294967295_u32;
    let _j = 18446744073709551615_u64;
    let _k = 340282366920938463463374607431768211455_u128; 
    let _l = 115792089237316195423570985008687907853269984665640564039457584007913129639935_u256;

    let _m: usize = 4294967295; // usize is same as u32
    let _n = 4294967295_usize; // it is also the type _u32
    
}

fn signed_integers() {
    let _a: i8 = -128; // from -128 to 127 including 0
    let _b: i16 = -32768; // form -32768 to 32767 including 0
    let _c: i32 = -2147483648; // form -2147483648 to 2147483647 including 0
    let _d: i64 = -9223372036854775808; // form -9223372036854775808 to 9223372036854775807 including 0
    let _e: i128 = -170141183460469231731687303715884105728; // form -170141183460469231731687303715884105728 to 170141183460469231731687303715884105727 including 0
 // let _f: i256 = -57896044618658097711785492504343953926634992332820282019728792003956564819968; // i256 doesn't exist

    let _g = 127_i8;
    let _h = 32767_i16;
    let _i = 2147483647_i32;
    let _j = 9223372036854775807_i64;
    let _k = 170141183460469231731687303715884105727_i128;
 // let l = 57896044618658097711785492504343953926634992332820282019728792003956564819967_i256; // i256 doesn't exist

//  let _m: isize = 2147483647; // isize isn't exists
}

#[cfg(test)]
mod tests{
    use alexandria_math::fast_power::fast_power;
    use alexandria_math::fast_root::fast_sqrt;

    #[test]
    fn test_basic_uint_math(){
        let a: u8 = 3;
        let b: u8 = 5;

        assert!(a + b == 8);
        // assert!(a - b == 2); // it would panic, another virtue of integers(u8) over felt
        assert!(b - a == 2);
        assert!(a * b == 15);
        assert!(b / a == 1); // it was not allowed in felt but is allowed in integers(u8)
        assert!(b % a == 2);  // it was not allowed in felt but is allowed in integers(u8)
    }

    #[test]
    #[should_panic]
    fn test_uint_overflow_protection(){
        let _a: u8 = 255;
        let _b: u8 = 255;
        _a + _b; // it gives 510 which u8 can't hold and overflows, so panic should be mandatory
    }

    #[test]
    #[should_panic]
    fn test_uint_underflow_protection(){
        let a: u8 = 0;
        let b: u8 = 1;
        a - b; // it gives -1 which u8 can't hold and underflows, so panic should be mandatory
    }

    #[test]
    fn test_basic_int_math() {
        let a: i8 = 3;
        let b: i8 = 5;

        assert!(a + b == 8);
        assert!(a - b == -2); // it would not panic, since we are using signed integers where negative values are allowed
        assert!(b - a == 2);
        assert!(a * b == 15);
        assert!(b / a == 1); // it was not allowed in felt but is allowed in integers(u8)
        assert!(b % a == 2);  // it was not allowed in felt but is allowed in integers(u8)
    }

    #[test]
    #[should_panic]
    fn test_int_overflow_protection(){
        let a: i8 = 127;
        let b: i8 = 1;
        a + b; // it gives 128 which i8 can't hold and overflows, so panic should be mandatory
    }

    #[test]
    #[should_panic]
    fn test_int_underflow_protection(){
        let a: i8 = -128;
        let b: i8 = 1;
        a - b; // it gives -1 which u8 can't hold and underflows, so panic should be mandatory
    }

    #[test]
    fn test_mixing_types_success(){
        let a: u8 = 3;
        let b: i8 = 5;
        assert!(a + b.try_into().unwrap() == 8); // here we are changing b into u8 form i8
    }

    #[test]
    fn mixing_type_fail(){
        let a: u8 = 3;
        let b: i8 = -5;
        // assert!(a + b.try_into().unwrap() == -2);
        assert!(a.try_into().unwrap() + b == -2) // we can change the order or typecasting
    }

    #[test]
    fn test_advanced_math() {
        let a: u32 = 4;
        assert!(fast_power(a, 2) == 16);
        assert!(fast_sqrt(a.try_into().unwrap(), 1) == 2) // i128 expected form library, so we need to typecast a
    }
    
}