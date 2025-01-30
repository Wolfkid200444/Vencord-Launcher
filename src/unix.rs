use std::path::PathBuf;

pub fn get_discord(name: &str) -> Option<PathBuf> {
    let data_dir = dirs::data_local_dir()?;

    let dir = data_dir.join(name);

    dbg!(&dir.read_dir());

    if !dir.join("Update.exe").exists() {
        return None;
    }

    todo!();
}
