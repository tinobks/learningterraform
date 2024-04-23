output "ip_windows" {
    value = module.vmwindows.windows_vm_public_ip
}

output "ip_linux" {
    value = module.vmlinux.linux_vm_public_ip
}