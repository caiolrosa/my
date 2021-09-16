mod widgets;

use std::{env, process};

//
// DISCLAIMER:
// This code is far from production ready, use at your own discretion
//

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() == 1 {
        eprintln!("Module settings must be provided");
        process::exit(1)
    }

    match args.get(1).map(|a| a.as_str()) {
        Some("checklist") => software_checklist(&args[2..]),
        Some(cmd) => { println!("Command {} not found", cmd); process::exit(1) },
        None => { eprintln!("Failed to parse the command"); process::exit(1) },
    }
}

fn software_checklist(args: &[String]) {
    let rows: Vec<_> = args.chunks_exact(2).collect();
    if rows.is_empty() {
        eprintln!("Checklist requires parameters in pairs [ID, Name]"); process::exit(1);
    }

    let options: Vec<_> = rows.iter().map(|row| {
        return match row.get(1) {
            Some(name) => name.to_string(),
            None => { eprintln!("Failed parsing row, it must contain 2 elements"); process::exit(1) },
        };
    }).collect();

    let selected_indexes = widgets::checklist("Which software do you want to install", options);

    let selections: Vec<_> = match selected_indexes {
        Some(indexes) => indexes.iter().map(|i| rows.get(*i).unwrap()).collect(),
        None => vec![],
    };

    let ids: Vec<_> = selections.iter().map(|s| s.first().unwrap().clone()).collect();
    println!("{}", ids.join(";"))
}
