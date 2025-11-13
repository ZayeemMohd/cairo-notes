// snapshots are readonly(immutable) without taking ownership, references are (mutable) and return ownership

#[cfg(test)]

mod tests {

    #[derive(Drop)]
    struct Person {
        height: u32, 
        age: u32
    }

    // this function is trying to take "struct" and try to mutate the value so we need to use "mut" to mutate the struct
    fn make_person_older(mut person: Person) {
        person.age += 1
    }

    #[test]
    fn test_take_ownership() {
        let person = Person {
            height: 180, 
            age: 30
        };

        // are we passing ownership again? answer is YES!
        make_person_older(person);
        // assert!(person.age == 30_u32) // we get the error "variable was previously moved"
        // how do we solve? use snapshot? Nope: snapshots doesn't work in this case because snapshots are readonly version of the property, you cannot make modification to the property
    }

    fn make_person_older_return_ownership(mut person: Person) -> Person{
        person.age += 1;
        person
    }

    #[test]
    fn test_make_person_older_return_ownership() {
        let person = Person {
            height: 180,
            age: 23
        };

        // not only it returns the ownership but also shadowing the above "person" variable
        let person = make_person_older_return_ownership(person);
        assert!(person.age == 24_u32);
    }

    // we also have a short hand for refrences just like snapshots instead of returning Person(struct) ownership each time, it is like a syntactic sugar to (mut person: Person) -> Person
    fn make_person_older_with_reference(ref person: Person){
        person.age +=1;
        // we don't have to explicitly return the person here
    }

    #[test]
    fn test_make_person_older_with_reference() {
        // we need to add "mut" here
        let mut person = Person {
            height: 180,
            age: 23
        };
        make_person_older_with_reference(ref person);
        // let person = make_person_older_return_ownership(person); // we don't have to capture value here again
        assert!(person.age == 24_u32);
    }
}