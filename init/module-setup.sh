#!/bin/bash
# module-setup.sh for kdump dracut module

. /lib/kdump/setup-kdump.functions

check() {
    return 255
}

install() {
    # Get configuration
    kdump_get_config || return 1
    kdump_import_targets

    inst_hook pre-pivot 90 /lib/kdump/save_dump.sh
    inst_multiple makedumpfile makedumpfile-R.pl kdumptool \
	$KDUMP_REQUIRED_PROGRAMS

    kdump_setup_files "$initdir" "${!host_fs_types[*]}"
}