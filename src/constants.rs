#[cfg(windows)]
pub static LIBRARY: &str = "vencord_launcher";

#[cfg(not(windows))]
pub static LIBRARY: &str = "vencord_launcher.so";

pub static MOD_ENTRYPOINT: &str = "patcher.js";
pub static RELEASE_URL: &str = "https://api.github.com/repos/vendicated/vencord/releases/latest";
pub static RELEASE_URL_FALLBACK: &str = "https://vencord.dev/releases/vencord";
pub static RELEASE_INFO_FILE: &str = "release.json";
pub static RELEASE_ASSETS: &[&str] = &[
    // Patcher
    "patcher.js",
    "patcher.js.map",
    "patcher.js.LEGAL.txt",
    // Preload
    "preload.js",
    "preload.js.map",
    // Renderer JS
    "renderer.js",
    "renderer.js.map",
    "renderer.js.LEGAL.txt",
    // Renderer CSS
    "renderer.css",
    "renderer.css.map",
];
