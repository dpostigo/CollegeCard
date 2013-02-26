find -L "${SRCROOT}/assets" \
-type f -not -name ".*" \
-not -name "`basename ${INFOPLIST_FILE}`" \
| xargs -t -I {} \
cp {} ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/
