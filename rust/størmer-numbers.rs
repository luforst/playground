// Størmer numbers

fn max_prime_factor(mut n: i64) -> i64 {
    // initialize maximum prime factor variable with lowest value
    let mut max_prime = -1;

    while (n % 2) == 0 {
        max_prime = 2;
        n /= 2;
    }

    // at this point, n must be odd
    for i in (3..n.isqrt()+1).step_by(2) {
        while (n % i) == 0 {
            max_prime = i;
            n /= i;
        }
    }

    // handle the case when n is prime and greater than 2
    if n > 2 {
        max_prime = n;
    }

    return max_prime;
}

fn størmer(n: i64) -> () {
    // find the n first Størmer numbers
    let mut i = 1;
    // let mut størmer_numbers = [i64; 10];
    let mut count = 0;
    while count < n {
        let t = i * i + 1;
        if max_prime_factor(t) >= 2 * i {
            println!("{} ", i);
            // (append newfound Størmer number to størmer_numbers array)
            count += 1;
        }
        i += 1;
    }
    // return størmer_numbers;
}

fn main() {
//   println!("{}", max_prime_factor(100));
//   println!("{}", max_prime_factor(198));
//   println!("{}", max_prime_factor(101));
//   println!("{}", max_prime_factor(191));
//   println!("{}", max_prime_factor(144));
//   println!("{}", størmer(4));
   størmer(4);
   størmer(9);
   størmer(25);
   størmer(10000);
}

