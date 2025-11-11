#[cfg(test)]
mod tests {

    #[test]
    fn test_implicit_vs_explicit() {
        let a = 5; //if no type is assigned explicitly, cairo assigne felt252 as a type implicitly
        let b: felt252 = 5;
        // felt = filed element

        assert!(a == b);
    }

    #[test]
    fn test_math() {
        let a: felt252 = 4;
        let b: felt252 = 2;

        assert!(a + b == 6);
        assert!(a - b == 2);
        assert!(a * b == 8);
        // assert!(a / b == 2); 
        // assert!(a % b == 0);
    }

    #[test]
    #[ignore]
    #[should_panic] // we want this to panic, if it panics it is okay otherwise not
    fn test_overflow_felt_should_panic() {
        // P = 36185027886661311069865932815214971204146870204146870208012676262330495002472812908353;
        let p_div_by_ten: felt252 = 3618502788666131106986593281521497120414687020801267626233049500247281290835;
        p_div_by_ten * 100; //it will overflow but flet is letting it to overflow, sadly!

    }

    #[test]
    #[should_panic]
    fn test_overflow_u256_should_panic() {
        // 2^256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let max_u256: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        max_u256 * 100;
    }

    #[test]
    fn test_short_string() {
        // short string stores ascii value of characters. to define short string you must use '' not "".
        // using felt252 for short string bring the ability of limiting in size unlike the ByteArray which doesn't have any limit;
        // let short_string: felt252 = 'asdfdsfdffddasdfdfasdfdfdfddjjifasfd' // this gives error 
        let short_string: felt252 = 'a';
        assert!(short_string == 97);
    }


    #[test]
    fn test_byte_array() {
        // ByteArray must be defined in "".
        // it doesn't containg any limit to store string unlike short_string
        // it doesn't support unicode charcters only supports ascii
        let byte_array: ByteArray = "No limit of the size of this string";
        assert!(byte_array.len() == 35);
    }
}

