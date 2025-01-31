#![windows_subsystem = "windows"]

use vencord_launcher::discord::DiscordBranch;

static INSTANCE_ID: &str = "VencordPTB";
static DISCORD_BRANCH: DiscordBranch = DiscordBranch::PTB;
static DISPLAY_NAME: &str = "Discord PTB";

#[tokio::main]
async fn main() {
    vencord_launcher::launch(INSTANCE_ID, DISCORD_BRANCH, DISPLAY_NAME).await;
}
