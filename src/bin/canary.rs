#![windows_subsystem = "windows"]

use vencord_launcher::discord::DiscordBranch;

static INSTANCE_ID: &str = "VencordCanary";
static DISCORD_BRANCH: DiscordBranch = DiscordBranch::Canary;
static DISPLAY_NAME: &str = "Discord Canary";

#[tokio::main]
async fn main() {
    vencord_launcher::launch(INSTANCE_ID, DISCORD_BRANCH, DISPLAY_NAME).await;
}
