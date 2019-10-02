# Reset
COLOR_OFF='\033[0m'       # Text Reset

# Regular Colors
COLOR_BLACK='\033[0;30m'        # Black
COLOR_RED='\033[0;31m'          # Red
COLOR_GREEN='\033[0;32m'        # Green
COLOR_YELLOW='\033[0;33m'       # Yellow
COLOR_BLUE='\033[0;34m'         # Blue
COLOR_PURPLE='\033[0;35m'       # Purple
COLOR_CYAN='\033[0;36m'         # Cyan
COLOR_WHITE='\033[0;37m'        # White


LOG_ERROR()
{
    echo -e -n $COLOR_RED
    echo $@
    echo -e -n $COLOR_OFF
}

LOG_INFO()
{
    echo -e -n $COLOR_BLUE
    echo $@
    echo -e -n $COLOR_OFF
}

LOG_WARNING()
{
    echo -e -n $COLOR_YELLOW
    echo $@
    echo -e -n $COLOR_OFF
}
