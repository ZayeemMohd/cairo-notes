#[derive(Drop)]
struct Human {
    strength: u32,
    health: u32
}

#[derive(Drop)]
struct Alien {
    strength: u32,
    health: u32
}

trait Action<T> {

    // this is the factory method, that means it produces the characters
    fn new() -> T; 

    // these are the read-only methods
    fn get_health(self: @T) -> u32; // we are using "@" because this method is readonly, we use snapshot concept here
    fn get_strength(self: @T) -> u32;
    fn is_alive(self: @T) -> bool;

    // these are the write methods
    fn train(ref self: T); // we are using "ref" because this method will write(update), we use refrences concept here
    fn heal(ref self: T);
    fn hurt(ref self: T);
}

impl HumanImpl of Action<Human> {
    fn new() -> Human {
        Human {
            strength: 70,
            health: 100
        }
    }

    fn get_health(self: @Human) -> u32 {
        *self.health // "*" is important 'de-snap operator' in snapshots
    }

    fn get_strength(self: @Human) -> u32 {
        *self.strength
    }

    fn is_alive(self: @Human) -> bool {
        if *self.health > 0 {
            true
        } else {
            false
        }
    }


    fn train(ref self: Human) {
        if self.is_alive(){
            self.strength += 5
        }
    }

    fn heal(ref self: Human) {
        if self.is_alive(){
            // todo: add limit such no it does not exceed 100
           self.health += 10
        }
    }

    fn hurt(ref self: Human) {
        if self.health > 10 {
            self.health -= 10
        } else {
            self.health = 0;
        }
    }

}

impl AlienImpl of Action<Alien> {
    fn new() -> Alien {
        Alien {
            strength: 50,
            health: 100
        }
    }

    fn get_health(self: @Alien) -> u32 {
        *self.health // "*" is important 'de-snap operator' in snapshots
    }

    fn get_strength(self: @Alien) -> u32 {
        *self.strength
    }

    fn is_alive(self: @Alien) -> bool {
        if *self.health > 0 {
            true
        } else {
            false
        }
    }


    fn train(ref self: Alien) {
        if self.is_alive(){
            self.strength += 10
        }
    }

    fn heal(ref self: Alien) {
        if self.is_alive(){
            // todo: add limit such no it does not exceed 100
           self.health += 5
        }
    }

    fn hurt(ref self: Alien) {
        if self.health > 10 {
            self.health -= 10
        } else {
            self.health = 0;
        }
    }

}

#[cfg(test)]
mod tests {
    
    use super::*;

    fn human_vs_human_fight(ref human1: Human, ref human2: Human) -> Result<(), ByteArray>{
        if !human1.is_alive() || !human2.is_alive() {
            return Result::Err("One of the opponents is already dead");
        }

        if human1.get_strength() == human2.get_strength() {
            human1.hurt();
            human2.hurt();
        } else if human1.get_strength() > human2.get_strength() {
            human2.hurt();
        } else {
            human1.hurt();
        }

        return Result::Ok(());
    }

     #[test]
     fn test_human_vs_human_fight() {
        let mut khalid: Human = HumanImpl::new();
        let mut saif: Human = HumanImpl::new();

        match human_vs_human_fight(ref khalid, ref saif) {
            Result::Ok(()) => {
                assert!(khalid.get_health() == 90);
                assert!(saif.get_health() == 90);
                assert!(khalid.is_alive());
                assert!(saif.is_alive());
            },
            Result::Err(_e) => assert!(false)
        }
     }
   
     fn fight<T1, T2>(ref fighter_1: T1, ref fighter_2: T2) -> Result<(), ByteArray> {

        if !fighter_1.is_alive() || !fighter_2.is_alive() {
            return Result::Err("One of the opponents is already dead");
        }

        if fighter_1.get_strength() == fighter_2.get_strength() {
            fighter_1.hurt();
            fighter_2.hurt();
        } else if fighter_1.get_strength() > fighter_2.get_strength() {
            fighter_2.hurt();
        } else {
            fighter_1.hurt();
        }

        return Result::Ok(());
     }  

     #[test]
     fn test_fight() {
        let mut kahlid: Human = HumanImpl::new();
        let mut saif: Alien = AlienImpl::new();

        match fight(ref kahlid, ref saif) {
            Result::Ok(()) => {
                assert!(saif.get_health() == 90_u32);
                assert!(kahlid.get_health() == 100_u32);
                assert!(kahlid.is_alive());
                assert!(saif.is_alive());
            },
            Result::Err(_e) => assert!(false)
        }
     }

}