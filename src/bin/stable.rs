#![windows_subsystem = "windows"]

use vencord_launcher::discord::DiscordBranch;

static INSTANCE_ID: &str = "VencordStable";
static DISCORD_BRANCH: DiscordBranch = DiscordBranch::Stable;
static DISPLAY_NAME: &str = "Discord Stable";

#[tokio::main]
async fn main() {
    vencord_launcher::launch(INSTANCE_ID, DISCORD_BRANCH, DISPLAY_NAME).await;
}
