# Color Codes
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White


echo -e "$White***********************************************"
echo "         Compiling Kernel             "
echo -e "***********************************************$nocol"

LC_ALL=C date +%Y-%m-%d
kernel_dir=$PWD
build=$kernel_dir/out
export CROSS_COMPILE="/home/sh/aosp-caf/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
kernel="-sYYLG"
version="0.0"
vendor="Xiaomi"
device="land"
date=`date +"%Y%m%d-%H%M"`
config=land_defconfig
kerneltype="Image.gz-dtb"
jobcount="-j$(grep -c ^processor /proc/cpuinfo)"
export KBUILD_BUILD_USER=sh
export KBUILD_BUILD_HOST=W650KL

echo "Checking for build..."
if [ -d arch/arm64/boot/"$kerneltype" ]; then
	read -p "Previous build found, clean working directory..(y/n)? : " cchoice
	case "$cchoice" in
		y|Y )
			rm -rf out
			mkdir out
			export ARCH=arm64
			make O=out clean && make O=out mrproper
			echo "Working directory cleaned...";;
		n|N )
			exit 0;;
		* )
			echo "Invalid...";;
	esac
	read -p "Begin build now..(y/n)? : " dchoice
	case "$dchoice" in
		y|Y)
			make O=out "$config"
			make O=out "$jobcount"
			exit 0;;

		n|N )
			exit 0;;
		* )
			echo "Invalid...";;
	esac
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$Green Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
fi
echo "Extracting files..."
if [ -f arch/arm64/boot/"$kerneltype" ]; then
echo " "
else
	echo "Nothing has been made..."
	read -p "Clean working directory..(y/n)? : " achoice
	case "$achoice" in
		y|Y )
                        rm -rf out
                        mkdir out
			export ARCH=arm64
                        make O=out clean && make O=out mrproper
                        echo "Working directory cleaned...";;
		n|N )
			exit 0;;
		* )
			echo "Invalid...";;
	esac
	read -p "Begin build now..(y/n)? : " bchoice
	case "$bchoice" in
		y|Y)
			make O=out "$config"
			make O=out "$jobcount"
			exit 0;;
		n|N )
			exit 0;;
		* )
			echo "Invalid...";;
	esac
fi
# Export script by Savoca
