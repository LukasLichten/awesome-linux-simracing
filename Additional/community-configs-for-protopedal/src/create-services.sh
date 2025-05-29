#!/usr/bin/env bash

echo "Creating systemd services for protopedal"
echo ""

# list device files in device-database
DEVICES=$(echo device-database/*)
SERVICES_DIR="output/services"

mkdir -p "$SERVICES_DIR"

for DEVICE in $DEVICES; do
    SERVICE_CONTENT=$(cat src/templates/service-template.service)
    SERVICE_NAME="protopedal-<device>@.service"
    NAME=""
    SHORTNAME=""

    DEVICE_ONLY=$(cut -d "/" -f 2 <<< "$DEVICE")
    echo "Creating service for $DEVICE_ONLY"

    while read -r LINE; do
        PROPERTY=$(cut -d "=" -f 1 <<< "$LINE")
        VALUE=$(cut -d "=" -f 2 <<< "$LINE")

        case $PROPERTY in
            name)
                NAME="$VALUE"
                ;;

            shortname)
                SHORTNAME="$VALUE"
                ;;
        esac
    done < "$DEVICE"

    SERVICE_CONTENT=$(sed "s/<device>/$NAME/g" <<< "$SERVICE_CONTENT")
    SERVICE_CONTENT=$(sed "s/<device-short>/$SHORTNAME/g" <<< "$SERVICE_CONTENT")

    SERVICE_NAME=$(sed "s/<device>/$SHORTNAME/g" <<< "$SERVICE_NAME")

    echo "$SERVICE_CONTENT" > "$SERVICES_DIR/$SERVICE_NAME"
done

echo ""
echo "Done creating systemd services for protopedal"
echo ""
