use winapi::um::winuser::{MB_ICONERROR, MB_ICONINFORMATION, MB_ICONWARNING, MB_OK};

#[repr(u32)]
pub enum MessageBoxIcon {
    Error = MB_ICONERROR | MB_OK,
    Info = MB_ICONINFORMATION | MB_OK,
    Warning = MB_ICONWARNING | MB_OK,
}

pub fn messagebox(title: &str, body: &str, icon: MessageBoxIcon) {
    use std::os::windows::ffi::OsStrExt;

    use winapi::um::winuser::MessageBoxW;

    let title = std::ffi::OsStr::new(title)
        .encode_wide()
        .chain(std::iter::once(0))
        .collect::<Vec<_>>();

    let body = std::ffi::OsStr::new(body)
        .encode_wide()
        .chain(std::iter::once(0))
        .collect::<Vec<_>>();

    unsafe {
        MessageBoxW(
            std::ptr::null_mut(),
            body.as_ptr(),
            title.as_ptr(),
            icon as u32,
        );
    }
}
