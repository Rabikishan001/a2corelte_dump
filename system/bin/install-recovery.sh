#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/13540000.dwmmc0/by-name/RECOVERY:22235680:d85cda3089bb0a6b5dc850d1812d09f81c25e50c; then
  applypatch EMMC:/dev/block/platform/13540000.dwmmc0/by-name/BOOT:17990176:61432b2ffe11d1a513f6932188de27f4db21eaa2 EMMC:/dev/block/platform/13540000.dwmmc0/by-name/RECOVERY d85cda3089bb0a6b5dc850d1812d09f81c25e50c 22235680 61432b2ffe11d1a513f6932188de27f4db21eaa2:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || echo 454 > /cache/fota/fota.status
else
  log -t recovery "Recovery image already installed"
fi

if [ -e /cache/recovery/command ] ; then
  PACKAGE_PATH=""
  SEARCH_COMMAND="--update_package"
  PATH_POS=16
  if [ -e '/system/bin/grep' ] ; then
    PACKAGE_PATH=`cat /cache/recovery/command | grep 'update_package'`
    PACKAGE_ORG_PATH=`cat /cache/recovery/command | grep 'update_org_package'`
    if [ "$PACKAGE_ORG_PATH" != "" ] ; then
      PACKAGE_PATH=$PACKAGE_ORG_PATH
      SEARCH_COMMAND="--update_org_package"
      PATH_POS=20
    fi
    if [ -e /cache/recovery/saved" ] ; then
      rm -rf /cache/recovery/saved
    fi

    if [ -e /data/.recovery/saved" ] ; then
      rm -rf /data/.recovery/saved
    fi
  fi
  if [ "$PACKAGE_PATH" != "" ] ; then
    for PACKAGE_LINE in $PACKAGE_PATH
    do
      if [ ${PACKAGE_LINE:0:$PATH_POS} == $SEARCH_COMMAND ] ; then
        break
      fi
    done
    let PATH_POS+=1
    PACKAGE_PATH=${PACKAGE_LINE:$PATH_POS}
    if [ "$PACKAGE_PATH" != "" ] ; then
      rm $PACKAGE_PATH
    fi
  fi
  if [ ${PACKAGE_PATH:0:5} == "/data" ] ; then
    echo $PACKAGE_PATH > /cache/fota/fota_path_command
    chown system:system /cache/fota/fota_path_command
  fi
  rm /cache/recovery/command
fi
