// we use "Option<>" when we have either a "value" of "empty/none"
fn find_even(x: u32) -> Option<u32> {
    if x % 2 == 0 {
        Option::Some(x)
    } else {
        Option::None
    }
}

// we use "Result" we have either a "value" or "error"
fn divide(a: u32, b: u32) -> Result<u32, ByteArray>{
    if b == 0 {
        Result::Err("Can't divide with zero")
    } else {
        Result::Ok(a / b)
    }
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_divide_by_zero_should_fail() {
        let result = divide(10, 0);
        // check whether this Result<> fives error or not 
        assert!(result.is_err())
    }

    #[test]
    fn test_divide_by_zero_should_fail_match() {
        let result = divide(10, 0);
        match result {
            Result::Err(_) => assert!(true),
            Result::Ok(_) => assert!(false)
        }
    }

    #[test]
    fn test_divide_by_zero_should_fail_with_error() {
        let result = divide(10, 0);
        match result {
            Result::Err(error) => assert!(error == "Can't divide with zero"),
            Result::Ok(_) => assert!(false)
        }
    }

    #[test]
    fn test_divide_by_zero_should_fail_shorthand() {
        let result = divide(10, 0);
        match result {
            Err(error) => assert!(error == "Can't divide with zero"),
            Ok(_) => assert!(false)
        }
    }

    #[test]
    fn test_divide_by_zero_should_error_match_default() {
        let result = divide(10, 0);
        match result {
            Err(_) => assert!(true),
            // when you enum has more than 2 members and you only want to check for the "err" and others as default
            _ => assert!(false)
        }
    }
}