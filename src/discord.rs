use std::path::PathBuf;

#[derive(Clone, Copy)]
pub enum DiscordBranch {
    Stable,
    Canary,
    PTB,
    Development,
}

#[cfg(windows)]
pub fn get_discord(branch: DiscordBranch) -> Option<PathBuf> {
    let local_appdata = dirs::data_local_dir()?;

    let name = match branch {
        DiscordBranch::Stable => "Discord",
        DiscordBranch::PTB => "DiscordPTB",
        DiscordBranch::Canary => "DiscordCanary",
        DiscordBranch::Development => "DiscordDevelopment",
    };

    let dir = local_appdata.join(name);

    if !dir.join("Update.exe").exists() {
        return None;
    }

    Some(dir)
}

#[cfg(target_os = "linux")]
pub fn get_discord(branch: DiscordBranch) -> Option<PathBuf> {
    let local_share = dirs::data_local_dir()?;

    // Try non-flatpak installs first.
    let (name, dvm_branch) = match branch {
        DiscordBranch::Stable => ("Discord", "stable"),
        DiscordBranch::PTB => ("DiscordPTB", "ptb"),
        DiscordBranch::Canary => ("DiscordCanary", "canary"),
        DiscordBranch::Development => ("DiscordDevelopment", "development"),
    };

    // On linux, the executable is at /home/user/.local/share/DiscordCanary/DiscordCanary
    let executable = local_share.join(name).join(name);

    if executable.is_file() {
        dbg!(&executable);
        return Some(executable);
    }

    // If that doesn't work, try $HOME/.dvm/branches

    let executable = dirs::home_dir()?.join(format!(".dvm/branches/{dvm_branch}/{name}/{name}"));

    if executable.is_file() {
        dbg!(&executable);
        return Some(executable);
    }

    // FIXME: Flatpak Support https://github.com/MeguminSama/Vencord-Launcher/issues/1
    // let (rdns, name, exec) = match branch {
    //     DiscordBranch::Stable => ("com.discordapp.Discord", "discord", "Discord"),
    //     DiscordBranch::PTB => ("com.discordapp.DiscordPTB", "discord-ptb", "DiscordPTB"),
    //     DiscordBranch::Canary => (
    //         "com.discordapp.DiscordCanary",
    //         "discord-canary",
    //         "discordCanary",
    //     ),
    //     DiscordBranch::Development => (
    //         "com.discordapp.DiscordDevelopment",
    //         "discord-development",
    //         "DiscordDevelopment",
    //     ),
    // };

    // let flatpak_path = format!("flatpak/app/{rdns}/current/active/files/{name}");

    // let executable = local_share.join(&flatpak_path).join(exec);

    // if executable.is_file() {
    //     dbg!(&executable);
    //     return Some(executable);
    // }

    // // If that fails, try flatpak (system).
    // // /var/lib
    // let executable = PathBuf::from(format!("/var/lib/{flatpak_path}/{exec}"));

    // if executable.is_file() {
    //     dbg!(&executable);
    //     return Some(executable);
    // }

    None
}

#[cfg(target_os = "macos")]
pub fn get_discord(name: &str) -> Option<PathBuf> {
    todo!();
}
