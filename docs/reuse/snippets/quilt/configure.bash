cat <<'EOF' > ~/.quiltrc
#!/usr/bin/env bash
set -euo pipefail

# find the root of a debian source tree:
SourcePackageRoot="${PWD}"
while [ ! -s "$SourcePackageRoot/debian/source/format" ]
do
    if [ "${SourcePackageRoot}" = '/' ]
    then
        echo -e '\033[1;33mWARNING\033[0m: You are not in a debian source tree!'
        exit 0
    fi

    SourcePackageRoot="$(readlink --canonicalize-existing "${SourcePackageRoot}/..")"
done

if ! grep --silent --fixed-strings '3.0 (quilt)' \
    "${SourcePackageRoot}/debian/source/format"
then
    echo -e '\033[1;33mWARNING\033[0m: This source package does \033[1mNOT\033[0m uses the 3.0 (quilt) format. The corresponding defaults defined in ~/.quiltrc do not get applied.'
    exit 0
fi

# tell quilt where to find patches for a 3.0 (quilt) source package
: "${QUILT_PATCHES:="${SourcePackageRoot}/debian/patches"}"

# create the quilt control files directory at the root of the source package
: "${QUILT_PC:="${SourcePackageRoot}/.pc"}"

# default options for the patch(1) tool
: "${QUILT_PATCH_OPTS:="--reject-format=unified"}"

# how quilt output should be colored
: "${QUILT_COLORS:="diff_hdr=1;32:diff_add=1;34:diff_rem=1;31:diff_hunk=1;33:diff_ctx=35:diff_cctx=33"}"

# set default arguments for quilt commands: 
: "${QUILT_DIFF_ARGS:="-p ab --no-timestamps --no-index --color=auto"}"
: "${QUILT_PATCHES_ARGS:="--color=auto"}"
: "${QUILT_PUSH_ARGS:="--color=auto"}"
: "${QUILT_REFRESH_ARGS:="-p ab --no-timestamps --no-index"}"
: "${QUILT_SERIES_ARGS:="--color=auto"}"
EOF