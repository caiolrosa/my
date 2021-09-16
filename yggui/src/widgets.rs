use dialoguer::{MultiSelect, theme::ColorfulTheme};

pub fn checklist(title: &str, options: Vec<String>) -> Option<Vec<usize>> {
    let defaults: Vec<bool> = options.iter().map(|_| true).collect();

    MultiSelect::with_theme(&ColorfulTheme::default())
        .with_prompt(title)
        .items(&options)
        .defaults(&defaults)
        .interact().ok()
}
