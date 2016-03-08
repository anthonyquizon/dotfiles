export PLATFORM=~/Development/Projects/platform/
export CORE=$PLATFORM/core

VENDOR=$PLATFORM/vendor
VENDOR_PATH=$VENDOR/bin
VENDOR_LIB=$VENDOR/lib

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export ANT_HOME=$VENDOR_LIB/apache-ant-1.9.4
export TOMCAT_HOME=$VENDOR_LIB/apache-tomcat-7.0.56
export PACKER_HOME=$VENDOR_LIB/packer-0.7.2
export FLEX_HOME=$VENDOR_LIB/adobe-flex-sdk-4.6

export PATH=$PATH:$PACKER_HOME

function platform-start {
    cd $CORE && vagrant up && ./gradlew runServices $@
}

function platform-stop {
    cd $CORE && ./gradlew stopServices $@
}

function platform-clean {
    cd $CORE/testing/build && rm startInteractionProcessRunner.err
}

function platform-build {
    cd $CORE && ./gradlew setup && ./gradlew build
    # TODO setup database
}

function platform-update {
    cd $CORE && git pull
    platform-build
}

function platform {
    case $1 in
        up)
            shift 1
            platform-start $@
            ;;
        down)
            shift 1
            platform-stop $@
            platform-clean
            ;;
        clean)
            platform-clean
            ;;
        update)
            platform-update
            ;;
        reset)
            platform-stop
            platform-clean
            platform-start
            ;;
    esac
}
