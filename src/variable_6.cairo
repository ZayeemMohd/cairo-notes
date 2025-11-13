const NUMBER: u8 = 3_u8;
const SMALL_NUMBER: u8 = 3_u8;

fn check() {
    println!("NUMBER is {}", NUMBER);
    println!("SMALL_NUMBER is {}", SMALL_NUMBER);
}


#[cfg(test)]

mod tests {

    use super::*;

    #[test]
    fn test_check_function(){
        assert!()
    }
}